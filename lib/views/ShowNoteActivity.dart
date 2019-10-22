import 'package:dolar_agora/dal/SQFLite.dart';
import 'package:dolar_agora/models/Note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';


class ShowNoteActivity extends StatefulWidget {
  int _noteId;
  ShowNoteActivity(this._noteId);

  @override
  _ShowNoteActivityState createState() => _ShowNoteActivityState();
}


class _ShowNoteActivityState extends State<ShowNoteActivity> {
  Note _note = Note('', '');
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  void selectNoteFromDatabase() async {
    SQLFlite sqlFlite = SQLFlite();
    Note response = await sqlFlite.getNoteOfID(widget._noteId);

    setState(() {
      _note = response;
    });
  }

  void _onTapLink(url) async {
    if (await canLaunch(url)) {
      _globalKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Impossivel carregar pagina da web'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.fixed,
            backgroundColor: Colors.black,
            elevation: 5,
          )
      );

    } else {
      launch(url);
    }
  }

  @override
  void initState() {
    selectNoteFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: appBarNavigator(_note),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Scrollbar(
            child: Markdown(
              data: _note.description,
              onTapLink: _onTapLink,
            )
        ),
      ),
    );
  }
}

AppBar appBarNavigator(Note note) {
  return AppBar(
    backgroundColor: Colors.blueGrey[900],
    elevation: 0,
    title: Text(note.title),
  );
}
