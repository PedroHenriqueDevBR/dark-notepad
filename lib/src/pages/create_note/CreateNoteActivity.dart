import 'package:asuka/asuka.dart' as asuka;
import 'package:dark_notepad/src/core/dal/SQFLite.dart';
import 'package:dark_notepad/src/core/models/Note.dart';
import 'package:dark_notepad/src/pages/show_note/ShowNoteActivity.dart';
import 'package:flutter/material.dart';

class CreateNoteActivity extends StatefulWidget {
  late int? idNote;
  CreateNoteActivity({this.idNote});

  @override
  _CreateNoteActivityState createState() => _CreateNoteActivityState();
}

class _CreateNoteActivityState extends State<CreateNoteActivity> {
  //  bool _visible = false;
  int? _noteId;
  TextEditingController _txtTitle = TextEditingController();
  TextEditingController _txtDescription = TextEditingController();
  String _titleText = '';

  loadData() async {
    if (_noteId != null) {
      SQLFlite sqlFlite = SQLFlite();
      Note response = await sqlFlite.getNoteOfID(_noteId!);

      _txtTitle.text = response.title;
      _txtDescription.text = response.description;

      setState(() {
        _titleText = _txtTitle.text;
      });
    }
  }

  dynamic _createNote() async {
    SQLFlite sqlFlite = SQLFlite();

    if (_noteId == null) {
      Note note = Note(_txtTitle.text, _txtDescription.text);
      int response = await sqlFlite.addNote(note);

      setState(() {
        _noteId = response;
//        _visible = true;
      });
    } else {
      sqlFlite.updateNoteOfID(_noteId!, title: _txtTitle.text, description: _txtDescription.text);
    }

    setState(() {
      _titleText = _txtTitle.text;
    });
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

  void _viewMarkdown() {
    if (_noteId == null) {
      showMessage('Nada digitado até o momento');
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShowNoteActivity(_noteId!)),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
    this._noteId = widget.idNote;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleText),
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
              TextField(
                keyboardType: TextInputType.text,
                autofocus: true,
                autocorrect: true,
                cursorColor: Colors.grey[200],
                controller: _txtTitle,
                style: TextStyle(color: Colors.white, decorationColor: Colors.white, fontSize: 17),
                decoration: InputDecoration(
                  hintText: 'Escreva o título da anotação',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  _createNote();
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                cursorColor: Colors.grey[200],
                keyboardType: TextInputType.multiline,
                expands: false,
                minLines: 30,
                maxLines: null,
                controller: _txtDescription,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Descrição',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onChanged: (text) {
                  _createNote();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _viewMarkdown,
        icon: Icon(Icons.code),
        label: Text('View'),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
