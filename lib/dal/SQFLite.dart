import 'package:dark_notepad/models/Note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLFlite {
  List<Note> notes = [];

  _openDataBase() async {
    final pathDatabase = await getDatabasesPath();
    final databaseLocate = join(pathDatabase, 'simplenotes.db');

    var db = await openDatabase(
      databaseLocate,
      version: 1,
      onCreate: (db, dbLastVersion) {
        String sql = 'create table if not exists note ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'title VARCHAR, '
            'description TEXT'
            ')';
        db.execute(sql);
      },
    );

    return db;
  }

  addNote(Note note) async {
    Database db = await _openDataBase();

    Map<String, dynamic> dataNote = {'title': note.title, 'description': note.description};

    int response = await db.insert('note', dataNote);
    return response;
  }

  getAllNotes({required bool orderDefault}) async {
    Database db = await _openDataBase();

    String order = ';';
    if (orderDefault == true) {
      order = ' ORDER BY id DESC;';
    }
    String sql = "SELECT * FROM note" + order;

    List notes = await db.rawQuery(sql);
    List<Note> responseNotes = [];
    for (var note in notes) {
      Note noteItem = Note(note['title'], note['description'], id: note['id']);
      responseNotes.add(noteItem);
    }

    return responseNotes;
  }

  getNoteOfID(int id) async {
    Database db = await _openDataBase();

    String sql = "SELECT * FROM note where id = $id";
    List notes = await db.rawQuery(sql);

    List<Note> responseNotes = [];
    for (var note in notes) {
      Note noteItem = Note(note['title'], note['description'], id: note['id']);
      responseNotes.add(noteItem);
    }
    return responseNotes[0];
  }

  deleteNoteOfID(int id) async {
    Database db = await _openDataBase();
    String sql = "DELETE FROM note where id = $id";

    db.delete('note', where: 'id = ?', whereArgs: [id]);
  }

  updateNoteOfID(int id, {required String title, required String description}) async {
    Database db = await _openDataBase();

    Map<String, dynamic> dataNote = {};

    if (title != null) {
      dataNote['title'] = title;
    }
    if (description != null) {
      dataNote['description'] = description;
    }

    db.update(
      'note',
      dataNote,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
