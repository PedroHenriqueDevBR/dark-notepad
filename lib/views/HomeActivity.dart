import 'package:dolar_agora/dal/SQFLite.dart';
import 'package:dolar_agora/models/Note.dart';
import 'package:dolar_agora/views/ListItemConfiguration.dart';
import 'package:dolar_agora/views/ListItemNotes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'CreateNoteActivity.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Note> notes = [];
  bool _orderDesc = false;
  IconData _iconOrder = Icons.arrow_downward;

  _orderList() {
    IconData icon;

    setState(() {
      _orderDesc = !_orderDesc;
      getNotesFromDatabase();

      if (_orderDesc == true) {
        icon = Icons.arrow_upward;
      } else {
        icon = Icons.arrow_downward;
      }
      _iconOrder = icon;

    });
  }

  void _createNote() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreateNoteActivity()
      ),
    ).then((value) {
      getNotesFromDatabase();
    });
  }

  @override
  void initState() {
    getNotesFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Notas'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              _iconOrder,
              color: Colors.white,
            ),
            onPressed: _orderList,
          )
        ],
      ),
      body: Container(
        color: Colors.black,
        child: ListView.builder(
          padding: EdgeInsets.all(4),
          itemCount: notes.length,
          itemBuilder: createItemList,
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
                onPressed: () {
                  showModalBottomSheet<Null>(
                      context: context,
                      builder: (BuildContext context) {
                        return _BottomDrawer(context);
                      }
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  // Operaçoes de banco de dados

  getNotesFromDatabase() async {
    SQLFlite sqlFlite = SQLFlite();
    List<Note> response = await sqlFlite.getAllNotes(orderDefault: _orderDesc);

    setState(() {
      notes = response;
    });
  }

  deleteNote(int id) async {
    SQLFlite sqlFlite = SQLFlite();
    sqlFlite.deleteNoteOfID(id);
    getNotesFromDatabase();
  }

  Widget createItemList(context, index) {
    return Dismissible(
      key: Key('${notes[index].id}'),
      child: ListItemNotes(notes[index]),
      direction: DismissDirection.startToEnd,

      background: Container(
        color: Colors.red,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            )
          ],
        ),
      ),

      onDismissed: (direction) {
        print('Direction: $direction');

        if (direction == DismissDirection.startToEnd) {
          deleteNote(notes[index].id);
        }
      },
    );
  }

}

BottomAppBar bottomNavigator(context) {
  void _createNote() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreateNoteActivity()
      ),
    ).then((value) {
      ;
    });
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
            onPressed: () {
              showModalBottomSheet<Null>(
                  context: context,
                  builder: (BuildContext context) {
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

  void shareApp() {
    print('Compartilhar aplicativo.');
  }

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
//          ListItemConfiguration(Icons.color_lens, 'Alterar cor principal',
//              'Alterar a cor principal da aplicacao, cor dos itens e da barra de configuraçao'),
          ListItemConfiguration(context, Icons.library_books, 'Markdown',
              'Manual markdown, aprenda markdown e otimize as suas anotaçoes', true),
          ListItemConfiguration(context, Icons.share, 'Compartilhar',
              'Ajude a manter a aplicaçao funcionando, compartilhe com os seus amigos', false, itemFunction: shareApp),
        ],
      ),
    ),
  );
}
