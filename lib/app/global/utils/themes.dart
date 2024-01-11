import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/global/constants/colors.dart';

class Themes {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      primary: darkGrey,
      brightness: Brightness.light,
      seedColor: Colors.white,
      background: lightColor,
    ),
    appBarTheme: const AppBarTheme(color: lightColor),
    canvasColor: Colors.white,
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      primary: lightColor,
      brightness: Brightness.dark,
      seedColor: darkColor,
      background: const Color(0xFF2E2E2E),
    ),
    appBarTheme: const AppBarTheme(color: Color(0xFF2E2E2E)),
    canvasColor: darkGrey,
  );
}
