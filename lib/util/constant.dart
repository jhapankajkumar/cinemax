import 'package:flutter/material.dart';

class SharedDataManager {
  static final SharedDataManager _singleton = new SharedDataManager._internal();
  factory SharedDataManager() {
    return _singleton;
  }
  SharedDataManager._internal();
  int menuSelectedIndex = -1;
}

 ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFF303030),
  accentColor: Color(0xFF535556),
  fontFamily: 'Oxygen',
  brightness: Brightness.dark
);

TextStyle titleStyle = TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white);