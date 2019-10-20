import 'package:dolar_agora/models/Note.dart';
import 'package:flutter/material.dart';

import 'ShowNoteActivity.dart';


class ListItemNotes extends StatelessWidget {
  Note _note;

  ListItemNotes(this._note);

  @override
  Widget build(BuildContext context) {

    _showNote() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShowNoteActivity(1)
          )
      );
    }

    return Card(
      elevation: 0,
      color: Colors.deepPurpleAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        title: Text(
          this._note.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            textBaseline: TextBaseline.alphabetic
          ),
        ),
        subtitle: Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: Text(
            this._note.description,
            maxLines: 9,
            style: TextStyle(
            color: Colors.white,
            ),
          ),
        ),
        onTap: _showNote,
      ),
    );
  }
}
