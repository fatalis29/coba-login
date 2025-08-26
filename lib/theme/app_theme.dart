import 'package:flutter/material.dart';

class AppTheme {
  static final appTheme = ThemeData(
    colorScheme: const ColorScheme(
      primary: Colors.deepOrange, onPrimary: Colors.white, 
      secondary: Colors.deepOrangeAccent, onSecondary: Colors.black, 
      error: Colors.red, onError: Colors.white, 
      background: Color.fromRGBO(250, 250, 250, 1), onBackground: Colors.black,
      surface: Colors.white, onSurface: Colors.black,
      shadow: Color.fromRGBO(224, 224, 224, 1),
      brightness: Brightness.light
      ),
    useMaterial3: true,
    fontFamily: 'Roboto'
  );
}