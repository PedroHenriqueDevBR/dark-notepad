import 'package:dark_notepad/src/core/dal/SQFLite.dart';
import 'package:dark_notepad/src/core/models/Note.dart';
import 'package:dark_notepad/src/pages/show_note/show_note_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ShowNoteActivity extends StatefulWidget {
  int noteId;
  ShowNoteActivity(this.noteId);

  @override
  _ShowNoteActivityState createState() => _ShowNoteActivityState();
}

class _ShowNoteActivityState extends State<ShowNoteActivity> {
  late ShowNoteController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ShowNoteController();
    _controller.selectNoteFromDatabase(id: widget.noteId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RxBuilder(builder: (_) => Text(_controller.note.value.title)),
        backgroundColor: Colors.blueGrey.shade900,
        brightness: Brightness.dark,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Scrollbar(
          child: RxBuilder(
            builder: (context) => Markdown(
              data: _controller.note.value.description,
            ),
          ),
        ),
      ),
    );
  }
}
