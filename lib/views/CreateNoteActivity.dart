import 'package:flutter/material.dart';

class CreateNoteActivity extends StatefulWidget {
  @override
  _CreateNoteActivityState createState() => _CreateNoteActivityState();
}

class _CreateNoteActivityState extends State<CreateNoteActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarNavigator(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blueGrey[900],
        child: bodyMain(),
      ),
      bottomNavigationBar: bottomNavigator(context),
    );
  }
}


SingleChildScrollView bodyMain() {
  return SingleChildScrollView(
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
  );
}

AppBar appBarNavigator() {
  return AppBar(
    backgroundColor: Colors.blueGrey[900],
    elevation: 0,
  );
}

BottomAppBar bottomNavigator(context) {
  void _viewMarkdown() {
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
              Icons.rate_review,
              color: Colors.white,
            ),
            label: Text(
              'Visualizar',
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
        ],
      ),
    ),
  );
}