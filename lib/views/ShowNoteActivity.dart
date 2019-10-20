import 'package:dolar_agora/models/Note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';


class ShowNoteActivity extends StatefulWidget {

  int _noteId;
  ShowNoteActivity(this._noteId);

  @override
  _ShowNoteActivityState createState() => _ShowNoteActivityState();
}


class _ShowNoteActivityState extends State<ShowNoteActivity> {

  @override
  Widget build(BuildContext context) {

    Note _note = Note('teste', 'Mais um teste.');

    return Scaffold(
      appBar: appBarNavigator(_note.title),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: bodyMain(_note.description),
      ),
    );
  }
}


Scrollbar bodyMain(Note note) {
  return Scrollbar(
      child: Markdown(
        data: note.description,
      )
  );
}


AppBar appBarNavigator(String titleBar) {
  return AppBar(
    backgroundColor: Colors.blueGrey[900],
    elevation: 0,
    title: Text(titleBar),
  );
}
