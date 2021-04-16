import 'package:dark_notepad/src/core/components/ListItemConfiguration.dart';
import 'package:dark_notepad/src/core/models/Note.dart';
import 'package:flutter/material.dart';

class HomeComponents {
  Widget createItemList({required BuildContext context, required Note note, required Function onTap, required Function onEdit, required Function onDelete}) {
    return Dismissible(
      key: Key('${note.id}'),
      direction: DismissDirection.endToStart,
      background: Container(),
      secondaryBackground: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: Colors.red, size: 30),
          ],
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete();
        }
      },
      child: itemCardList(note: note, onEdit: onEdit, onTap: onTap),
    );
  }

  Widget itemCardList({
    required Note note,
    required Function onEdit,
    required Function onTap,
  }) {
    return Card(
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
            style: TextStyle(color: Colors.white),
          ),
        ),
        trailing: IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              onEdit();
            }),
        onTap: () {
          onTap();
        },
      ),
    );
  }

  Widget btnCreateNote({required Function onTap}) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: Colors.deepPurpleAccent,
        visualDensity: VisualDensity.comfortable,
        padding: EdgeInsets.only(left: 8.0, right: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      icon: Icon(Icons.add, color: Colors.white),
      label: Text('Criar nota', style: TextStyle(color: Colors.white)),
      onPressed: () {
        onTap();
      },
    );
  }

  btnShowBottomDialog({required Function onTap}) {
    return TextButton.icon(
      icon: Icon(Icons.list, color: Colors.white),
      label: Text(''),
      onPressed: () {
        onTap();
      },
    );
  }

  Widget BottomDrawer({
    required BuildContext context,
    required Function shareFunction,
  }) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.deepPurple,
              height: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Configurações',
                    style: TextStyle(color: Colors.white, fontSize: 18),
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
            ListItemConfiguration(
              context: context,
              icon: Icons.share,
              title: 'Compartilhar',
              subtitle: 'Ajude a melhorar a aplicação compartilhando com os seus amigos',
              showMarkdown: false,
              itemFunction: shareFunction,
            ),
          ],
        ),
      ),
    );
  }
}
