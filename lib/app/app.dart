import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/routes/route_screens.dart';
import 'package:flutter_assessment/app/global/utils/themes.dart';
import 'package:provider/provider.dart';

import 'providers/theme_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, child) => MaterialApp.router(
        title: 'Flutter Demo',
        themeMode: provider.themeMode,
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: AppScreens.router,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown,
          },
        ),
      ),
    );
  }
}
