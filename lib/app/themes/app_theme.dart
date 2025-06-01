import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
    ),
  );

  static final dark = ThemeData.dark().copyWith(
    primaryColor: Colors.teal,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.teal,
    ),
  );
}