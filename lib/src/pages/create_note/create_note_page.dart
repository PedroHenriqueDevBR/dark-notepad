import 'package:dark_notepad/src/pages/create_note/create_note_components.dart';
import 'package:dark_notepad/src/pages/create_note/create_note_controller.dart';
import 'package:dark_notepad/src/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

class CreateNoteActivity extends StatefulWidget {
  int? id;
  CreateNoteActivity({this.id});
  @override
  _CreateNoteActivityState createState() => _CreateNoteActivityState();
}

class _CreateNoteActivityState extends State<CreateNoteActivity> with CreateNoteComponents {
  late CreateNoteController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CreateNoteController();
    _controller.noteId = widget.id;
    _controller.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RxBuilder(
          builder: (_) => Text(_controller.titleText.value),
        ),
        brightness: Brightness.dark,
        backgroundColor: Colors.blueGrey[900],
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blueGrey[900],
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              titleInput(
                txtTitle: _controller.txtTitle,
                onChange: _controller.createNote,
              ),
              SizedBox(height: 10),
              inputDescription(
                txtDescription: _controller.txtDescription,
                onChange: _controller.createNote,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.code),
        label: Text('View'),
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          _controller.viewMarkdown(context: context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
