import 'package:dark_notepad/src/pages/home/home_components.dart';
import 'package:dark_notepad/src/pages/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with HomeComponents {
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
      backgroundColor: Colors.blueGrey.shade900.withBlue(80),
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('Dark Notepad'),
        actions: [
          RxBuilder(
            builder: (_) => IconButton(
              tooltip: 'Ordenação',
              icon: Icon(_controller.iconOrder.value, color: Colors.white),
              onPressed: _controller.orderList,
            ),
          ),
        ],
      ),
      body: Container(
        child: RxBuilder(builder: (_) {
          return ListView.builder(
            padding: EdgeInsets.all(4),
            itemCount: _controller.notes.length,
            itemBuilder: (context, index) {
              return createItemList(
                context: context,
                note: _controller.notes[index],
                onTap: () => _controller.showNote(context: context, id: _controller.notes[index].id!),
                onEdit: () => _controller.editNote(context: context, id: _controller.notes[index].id!),
                onDelete: () => _controller.deleteNote(id: _controller.notes[index].id!),
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
            children: [
              btnCreateNote(onTap: () => _controller.createNote(context: context)),
              btnShowBottomDialog(
                onTap: () => () {
                  showModalBottomSheet<Null>(
                    context: context,
                    builder: (BuildContext context) {
                      return BottomDrawer(context: context, shareFunction: _controller.shareApp);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
