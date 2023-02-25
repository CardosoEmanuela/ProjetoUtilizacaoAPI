import 'package:flutter/material.dart';

class Tema {
  criaTema() {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: Color.fromARGB(255, 89, 128, 172),
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ));
  }
}
