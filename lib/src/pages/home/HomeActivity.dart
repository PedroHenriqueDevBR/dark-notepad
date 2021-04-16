import 'package:asuka/asuka.dart' as asuka;
import 'package:dark_notepad/src/core/dal/SQFLite.dart';
import 'package:dark_notepad/src/core/models/Note.dart';
import 'package:dark_notepad/src/pages/show_note/ShowNoteActivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../create_note/CreateNoteActivity.dart';
import '../../core/components/ListItemConfiguration.dart';
import '../show_note/ShowNoteActivity.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note> notes = [];
  bool _orderDesc = false;
  IconData _iconOrder = Icons.arrow_downward;

  @override
  void initState() {
    getNotesFromDatabase();
    super.initState();
  }

  void showMessage(String message) {
    asuka.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Markdown Editor'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Ordenação',
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
                  style: TextStyle(color: Colors.white),
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
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _orderList() {
    IconData icon;
    String order = '';

    setState(() {
      _orderDesc = !_orderDesc;
      getNotesFromDatabase();

      if (_orderDesc == true) {
        icon = Icons.arrow_upward;
        order = 'decrescente';
      } else {
        icon = Icons.arrow_downward;
        order = 'crescente';
      }

      _iconOrder = icon;
      showMessage(order);
    });
  }

  _createNote() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateNoteActivity()),
    ).then((value) {
      getNotesFromDatabase();
    });
  }

  _showNote(int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowNoteActivity(index)));
  }

  _editNote(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateNoteActivity(
                  idNote: index,
                ))).then((value) {
      getNotesFromDatabase();
    });
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

    showMessage('Nota deletada');
  }

  Widget createItemList(context, index) {
    Note _note = notes[index];

    return Dismissible(
      key: Key('${notes[index].id}'),
      direction: DismissDirection.horizontal,
      background: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            )
          ],
        ),
      ),
      secondaryBackground: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            )
          ],
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          deleteNote(notes[index].id!);
        }
      },
      child: Card(
        elevation: 0,
        color: Colors.deepPurpleAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          title: Text(
            _note.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, textBaseline: TextBaseline.alphabetic),
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
          trailing: IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                _editNote(_note.id!);
              }),
          onTap: () {
            _showNote(_note.id!);
          },
        ),
      ),
    );
  }
}

Widget _BottomDrawer(context) {
  void shareApp() {
    Share.share('Markdown editor, editor de markdown simples de utilizar, sem anúncios. '
        'Baixe agora mesmo em https://play.google.com/store/apps/details?id=com.pedrohenriquedevbr.dolar_agora');
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
                  'Configurações',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
//          ListItemConfiguration(Icons.color_lens, 'Alterar cor principal',
//              'Alterar a cor principal da aplicacao, cor dos itens e da barra de configuraçao'),
          ListItemConfiguration(
            context: context,
            icon: Icons.library_books,
            title: 'Markdown',
            subtitle: 'Manual markdown, aprenda markdown e otimize as suas anotações',
            showMarkdown: true,
            itemFunction: () {},
          ),
          ListItemConfiguration(context: context, icon: Icons.share, title: 'Compartilhar', subtitle: 'Ajude a melhorar a aplicação compartilhando com os seus amigos', showMarkdown: false, itemFunction: shareApp),
        ],
      ),
    ),
  );
}
