import 'package:dolar_agora/models/Note.dart';
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

    Map<String, dynamic> dataNote = {
      'title': note.title,
      'description': note.description
    };

    int response = await db.insert('note', dataNote);
    return response;
  }

  getAllNotes() async {
    Database db = await _openDataBase();

    String sql = "SELECT * FROM note";
    List notes = await db.rawQuery(sql);

    List<Note> responseNotes = [];
    for (var note in notes) {
      Note noteItem = Note(note['title'], note['description']);
      responseNotes.add(noteItem);
    }

    print('Notas: ' + notes.toString());
    return responseNotes;
  }

  listInit() {
    for (int i = 0; i < 15; i++) {
      this.addNote(Note('Nota $i',
          """
            # Markdown Example
            Markdown allows you to easily include formatted text, images, and even formatted Dart code in your app.
            
            ## Styling
            Style text as _italic_, __bold__, or `inline code`.
            
            - Use bulleted lists
            - To better clarify
            - Your points
            
            ## Links
            You can use [hyperlinks](hyperlink) in markdown
            
            ## Images
            
            You can include images:
            
            ![Flutter logo](https://flutter.io/images/flutter-mark-square-100.png#100x100)
            
            ## Markdown widget
            
            This is an example of how to create your own Markdown widget:
            
                new Markdown(data: 'Hello _world_!');
            
            ## Code blocks
            Formatted Dart code looks really pretty too:
            
            ```
            void main() {
              runApp(new MaterialApp(
                home: new Scaffold(
                  body: new Markdown(data: markdownData)
                )
              ));
            }
            ```
            
            Enjoy!
          """
      ));
    }
  }

}