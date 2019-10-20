import 'package:dolar_agora/dal/SQFLite.dart';
import 'package:dolar_agora/models/Note.dart';
import 'package:dolar_agora/views/ShowNoteActivity.dart';
import 'package:flutter/material.dart';

class CreateNoteActivity extends StatefulWidget {
  @override
  _CreateNoteActivityState createState() => _CreateNoteActivityState();
}

class _CreateNoteActivityState extends State<CreateNoteActivity> {

  TextEditingController _txtTitle = TextEditingController();
  TextEditingController _txtDescription= TextEditingController();
  int _noteId = -1;

  void _viewMarkdown() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ShowNoteActivity(_noteId)
      ),
    );
  }

  _createNote() async {
    SQLFlite sqlFlite = SQLFlite();
    Note note = Note(_txtTitle.text, _txtDescription.text);
    int response = await sqlFlite.addNote(note);
    _noteId = response;
    print('Nota criada com sucesso $response');
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
                minLines: 1,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[

              FlatButton.icon(
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