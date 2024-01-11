import 'package:flutter/material.dart';

class AppConstants {
  static InputDecoration textFieldDecoration({String? label}) {
    return InputDecoration(
      hintText: label,
      labelText: label,
      border: const OutlineInputBorder(),
    );
  }

  static ButtonStyle filledButtonStyle() {
    return FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  static TextStyle titleTextStyle() {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle semiTitleTextStyle() {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle bodyTextStyle() {
    return const TextStyle(fontSize: 16);
  }
}
