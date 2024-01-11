import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/app.dart';
import 'package:flutter_assessment/app/providers/theme_provider.dart';
import 'package:flutter_assessment/app/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
    ],
    child: const MyApp(),
  ));
}
