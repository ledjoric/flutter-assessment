import 'package:flutter_assessment/app/routes/route_names.dart';
import 'package:flutter_assessment/app/screens/auth_screens/signup_screen.dart';
import 'package:flutter_assessment/app/screens/nav_screens/about_screen.dart';
import 'package:flutter_assessment/app/screens/nav_screens/settings_screen.dart';
import 'package:flutter_assessment/app/screens/navigation_layout_screen.dart';
import 'package:flutter_assessment/app/screens/auth_screens/login_screen.dart';
import 'package:go_router/go_router.dart';

class AppScreens {
  static GoRouter router = GoRouter(
    initialLocation: loginScreen,
    routes: [
      GoRoute(
        path: loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: signupScreen,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: homeScreen,
        builder: (context, state) => const NavigationLayoutScreen(),
      ),
      GoRoute(
        path: settingScreen,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: aboutScreen,
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: dashboard,
        builder: (context, state) => const AboutScreen(),
      ),
    ],
  );
}
