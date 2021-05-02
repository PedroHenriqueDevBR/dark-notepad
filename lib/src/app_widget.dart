import 'package:dark_notepad/src/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/services.dart';

class App extends StatelessWidget {
  void changeBarColor() {
    SystemUiOverlayStyle appTheme = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.blueGrey.shade900,
      systemNavigationBarColor: Colors.blueGrey.shade900,
      systemNavigationBarDividerColor: Colors.blueGrey.shade900,
    );
    SystemChrome.setSystemUIOverlayStyle(appTheme);
  }

  @override
  Widget build(BuildContext context) {
    changeBarColor();
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
