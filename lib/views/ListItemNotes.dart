import 'package:dolar_agora/models/Note.dart';
import 'package:flutter/material.dart';

import 'ShowNoteActivity.dart';


class ListItemNotes extends StatefulWidget {
  Note note;
  ListItemNotes(this.note);

  @override
  _ListItemNotesState createState() => _ListItemNotesState();
}

class _ListItemNotesState extends State<ListItemNotes> {

  @override
  Widget build(BuildContext context) {
    Note _note = widget.note;

    _showNote(index) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShowNoteActivity(index)
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
              _note.title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  textBaseline: TextBaseline.alphabetic
              ),
            ),
            subtitle: Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              child: Text(
                _note.description,
                maxLines: 9,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () {
              _showNote(_note.id);
            },
          ),
    );
  }
}