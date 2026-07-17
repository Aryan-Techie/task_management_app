// centralized theme so colors and styles are consistent everywhere
// useMaterial3 enables the newer Material Design 3 look
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorSchemeSeed: Colors.blue,
    useMaterial3: true,
  );
}