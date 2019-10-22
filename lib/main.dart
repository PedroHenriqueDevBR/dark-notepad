import 'package:dolar_agora/views/HomeActivity.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.purple
    ),
    home: Home(),
  ));
}