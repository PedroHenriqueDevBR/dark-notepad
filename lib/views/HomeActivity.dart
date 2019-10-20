import 'package:dolar_agora/dal/SQFLite.dart';
import 'package:dolar_agora/models/Note.dart';
import 'package:dolar_agora/views/ListItemConfiguration.dart';
import 'package:dolar_agora/views/ListItemNotes.dart';
import 'package:dolar_agora/views/ShowNoteActivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CreateNoteActivity.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarNavigator(),
      body: bodyMain(context),
      bottomNavigationBar: bottomNavigator(context),
    );
  }
}

Container bodyMain(context) {

  Future<List<Note>> getNotesFromDatabase() async {
    SQLFlite sqlFlite = SQLFlite();
    List<Note> response = await sqlFlite.getAllNotes();
    return response;
  }
  List<Note> notes = [];

  return Container(
    color: Colors.black,
    child: ListView.builder(
      padding: EdgeInsets.all(3),
      itemCount: notes.length,
      itemBuilder: (context, index){
        return ListItemNotes(notes[index]);
      },
    ),

  );
}

AppBar appBarNavigator() {
  return AppBar(
    backgroundColor: Colors.blueGrey[900],
    title: Text('Notas'),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.filter_list,
          color: Colors.white,
        ),
        onPressed: (){},
      )
    ],
  );
}

BottomAppBar bottomNavigator(context) {
  void _createNote() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateNoteActivity()
        ),
    );
  }

  return BottomAppBar(
    color: Colors.blueGrey[900],
    elevation: 15,
    child: Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          FlatButton.icon(
            icon: Icon(
                Icons.add,
              color: Colors.white,
            ),
            label: Text(
                'Criar nota',
              style: TextStyle(
                color: Colors.white
              ),
            ),
            color: Colors.blueGrey[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onPressed: _createNote,
          ),

          FlatButton.icon(
            icon: Icon(
                Icons.list,
              color: Colors.white,
            ),
            label: Text(''),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onPressed: (){
              showModalBottomSheet<Null>(
                context: context,
                builder: (BuildContext context){
                  return _BottomDrawer(context);
                }
              );
            },
          ),
        ],
      ),
    ),
  );
}


Widget _BottomDrawer(context) {

  return Drawer(
    child: Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: Colors.deepPurple,
            height: 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                    'Configuraçoes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8,),
          ListItemConfiguration(Icons.color_lens, 'Alterar cor principal', 'Alterar a cor principal da aplicacao, cor dos itens e da barra de configuraçao'),
          ListItemConfiguration(Icons.library_books, 'Markdown', 'Manual markdown, aprenda markdown e otimize as suas anotaçoes'),
          ListItemConfiguration(Icons.share, 'Compartilhar', 'Ajude a manter a aplicaçao funcionando, compartilhe com os seus amigos'),
        ],
      ),
    ),
  );
}