import 'package:dolar_agora/dal/SQFLite.dart';
import 'package:dolar_agora/models/Note.dart';
import 'package:dolar_agora/views/ShowNoteActivity.dart';
import 'package:flutter/material.dart';

class CreateNoteActivity extends StatefulWidget {

  int idNote = null;
  CreateNoteActivity({this.idNote});

  @override
  _CreateNoteActivityState createState() => _CreateNoteActivityState(idNote);
}

class _CreateNoteActivityState extends State<CreateNoteActivity> {
  int _noteId;

  _CreateNoteActivityState(this._noteId);

  TextEditingController _txtTitle = TextEditingController();
  TextEditingController _txtDescription= TextEditingController();
  bool _visible = false;

  loadData() async {
    if (_noteId != null) {
      SQLFlite sqlFlite = SQLFlite();
      Note response = await sqlFlite.getNoteOfID(_noteId);

      _txtTitle.text = response.title;
      _txtDescription.text = response.description;

      setState(() {
        _visible = true;
      });
    }
  }

  _createNote() async {
    SQLFlite sqlFlite = SQLFlite();

    if (_noteId == null) {
      Note note = Note(_txtTitle.text, _txtDescription.text);
      int response = await sqlFlite.addNote(note);

      setState(() {
        _noteId = response;
        _visible = true;
      });
    } else {
      sqlFlite.updateNoteOfID(_noteId, title: _txtTitle.text, description: _txtDescription.text);
    }
  }

  void _viewMarkdown() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ShowNoteActivity(_noteId)
      ),
    );
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarNavigator(),

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
                style: TextStyle(
                    color: Colors.white,
                    decorationColor: Colors.white,
                    fontSize: 17
                ),
                decoration: InputDecoration(
                  hintText: 'Escreva o titulo da anotaçao',
                  hintStyle: TextStyle(
                      color: Colors.grey
                  ),
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: 10,),
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
                  hintText: 'Descricao',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),





      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey[900],
        elevation: 15,
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Visibility(
                visible: _visible,
                child: FlatButton.icon(
                  icon: Icon(
                    Icons.rate_review,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Visualizar nota ',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  color: Colors.blueGrey[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onPressed: _viewMarkdown,
                ),
              ),

              FlatButton.icon(
                icon: Icon(
                  Icons.save_alt,
                  color: Colors.white,
                ),
                label: Text(
                  'Salvar progresso',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                color: Colors.green[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                onPressed: _createNote,
              ),

            ],
          ),
        ),
      ),
    );
  }
}


AppBar appBarNavigator() {
  return AppBar(
    backgroundColor: Colors.blueGrey[900],
    elevation: 0,
  );
}