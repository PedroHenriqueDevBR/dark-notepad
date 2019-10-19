import 'package:dolar_agora/models/Note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';


class ShowNoteActivity extends StatefulWidget {

  Note _note;
  ShowNoteActivity(this._note);

  @override
  _ShowNoteActivityState createState() => _ShowNoteActivityState();
}


class _ShowNoteActivityState extends State<ShowNoteActivity> {

  @override
  Widget build(BuildContext context) {

    Note note = widget._note;

    return Scaffold(
      appBar: appBarNavigator(widget._note.title),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: bodyMain(note),
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
