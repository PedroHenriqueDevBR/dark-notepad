import 'package:asuka/asuka.dart' as asuka;
import 'package:dark_notepad/src/core/dal/SQFLite.dart';
import 'package:dark_notepad/src/core/models/Note.dart';
import 'package:dark_notepad/src/pages/show_note/ShowNoteActivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

class CreateNoteController {
//  bool _visible = false;
  int? noteId;
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  RxNotifier<String> titleText = RxNotifier<String>('');

  loadData() async {
    if (noteId != null) {
      SQLFlite sqlFlite = SQLFlite();
      Note response = await sqlFlite.getNoteOfID(noteId!);
      txtTitle.text = response.title;
      txtDescription.text = response.description;
      titleText.value = txtTitle.text;
    }
  }

  void createNote() async {
    SQLFlite sqlFlite = SQLFlite();
    if (noteId == null) {
      Note note = Note(txtTitle.text, txtDescription.text);
      int response = await sqlFlite.addNote(note);
      noteId = response;
    } else {
      sqlFlite.updateNoteOfID(noteId!, title: txtTitle.text, description: txtDescription.text);
    }
    titleText.value = txtTitle.text;
  }

  void showMessage(String message) {
    asuka.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
        elevation: 22,
        backgroundColor: Colors.deepPurple,
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }

  void viewMarkdown({required BuildContext context}) {
    if (noteId == null) {
      showMessage('Nada digitado até o momento');
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowNoteActivity(noteId!),
        ),
      );
    }
  }
}
