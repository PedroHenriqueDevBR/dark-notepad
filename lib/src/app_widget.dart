import 'package:dark_notepad/src/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: asuka.builder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Home(),
    );
  }
}
