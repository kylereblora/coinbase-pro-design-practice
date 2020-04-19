import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // For simplicity, I put all the Theme styles here.
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          height: 45,
          padding: EdgeInsets.all(15),
          buttonColor: Color(0xFF3232ff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: Color(0xFF3232ff),
        ),
        cursorColor: Color(0xFF3232ff),
      ),
      home: Home(),
    );
  }
}
