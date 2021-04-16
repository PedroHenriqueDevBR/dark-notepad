import 'package:dark_notepad/src/core/dal/SQFLite.dart';
import 'package:dark_notepad/src/core/models/Note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ShowNoteActivity extends StatefulWidget {
  int _noteId;
  ShowNoteActivity(this._noteId);

  @override
  _ShowNoteActivityState createState() => _ShowNoteActivityState();
}

class _ShowNoteActivityState extends State<ShowNoteActivity> {
  Note _note = Note('', '');

  void selectNoteFromDatabase() async {
    SQLFlite sqlFlite = SQLFlite();
    Note response = await sqlFlite.getNoteOfID(widget._noteId);

    setState(() {
      _note = response;
    });
  }

  @override
  void initState() {
    selectNoteFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarNavigator(_note),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Scrollbar(
            child: Markdown(
          data: _note.description,
        )),
      ),
    );
  }
}

AppBar appBarNavigator(Note note) {
  return AppBar(
    backgroundColor: Colors.blueGrey[900],
    elevation: 0,
    title: Text(note.title),
  );
}