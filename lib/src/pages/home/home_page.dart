import 'package:asuka/asuka.dart' as asuka;
import 'package:dark_notepad/src/core/dal/SQFLite.dart';
import 'package:dark_notepad/src/core/models/Note.dart';
import 'package:dark_notepad/src/pages/home/home_controller.dart';
import 'package:dark_notepad/src/pages/show_note/ShowNoteActivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:share/share.dart';

import '../create_note/CreateNoteActivity.dart';
import '../../core/components/ListItemConfiguration.dart';
import '../show_note/ShowNoteActivity.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeController _controller;

  @override
  void initState() {
    _controller = HomeController();
    _controller.getNotesFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.blueGrey[900],
        title: Text('Markdown Editor'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Ordenação',
            icon: Icon(
              _controller.iconOrder.value,
              color: Colors.white,
            ),
            onPressed: _controller.orderList,
          )
        ],
      ),
      body: Container(
        color: Colors.black,
        child: RxBuilder(builder: (value) {
          return ListView.builder(
            padding: EdgeInsets.all(4),
            itemCount: _controller.notes.length,
            itemBuilder: (context, index) {
              return createItemList(
                context: context,
                note: _controller.notes[index],
                onTap: () {
                  _controller.showNote(context: context, id: _controller.notes[index].id!);
                },
                onEdit: () {
                  _controller.editNote(context: context, id: _controller.notes[index].id!);
                },
                onDelete: () {
                  _controller.deleteNote(id: _controller.notes[index].id!);
                },
              );
            },
          );
        }),
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
                onPressed: () {
                  _controller.createNote(context: context);
                },
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

  Widget createItemList({
    required BuildContext context,
    required Note note,
    required Function onTap,
    required Function onEdit,
    required Function onDelete,
  }) {
    return Dismissible(
      key: Key('${note.id}'),
      direction: DismissDirection.endToStart,
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
        if (direction == DismissDirection.endToStart) {
          onDelete();
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
            note.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, textBaseline: TextBaseline.alphabetic),
          ),
          subtitle: Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            child: Text(
              note.description,
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
                onEdit();
              }),
          onTap: () {
            onTap();
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
