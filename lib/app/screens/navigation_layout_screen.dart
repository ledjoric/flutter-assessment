import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/data/services/user_services.dart';
import 'package:flutter_assessment/app/global/constants/colors.dart';
import 'package:flutter_assessment/app/providers/theme_provider.dart';
import 'package:flutter_assessment/app/screens/nav_screens/home_screen.dart';
import 'package:flutter_assessment/app/screens/nav_screens/profile_screen.dart';
import 'package:provider/provider.dart';

class NavigationLayoutScreen extends StatefulWidget {
  const NavigationLayoutScreen({super.key});

  @override
  State<NavigationLayoutScreen> createState() => _NavigationLayoutScreenState();
}

class _NavigationLayoutScreenState extends State<NavigationLayoutScreen> {
  int _selectedIndex = 0;

  PageController _pageController = PageController();

  List<Widget> screens = [
    const HomeScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async => getUserDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    bool isLightMode = provider.themeMode == ThemeMode.light;
    bool isWideScreen = MediaQuery.of(context).size.width > 600;

    if (isWideScreen) _pageController = PageController(initialPage: _selectedIndex);

    return Scaffold(
      body: isWideScreen
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NavigationRail(
                  backgroundColor: isLightMode ? Theme.of(context).canvasColor : darkGrey,
                  indicatorColor: isLightMode ? darkColor : lightColor,
                  useIndicator: true,
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) => setState(() => _selectedIndex = index),
                  selectedLabelTextStyle: TextStyle(color: isLightMode ? darkColor : lightColor),
                  selectedIconTheme:
                      IconThemeData(color: isLightMode ? Theme.of(context).colorScheme.onSecondary : darkGrey),
                  labelType: NavigationRailLabelType.selected,
                  elevation: 8,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.account_circle_outlined),
                      selectedIcon: Icon(Icons.account_circle),
                      label: Text('Profile'),
                    ),
                  ],
                ),
                Expanded(child: screens[_selectedIndex]),
              ],
            )
          : PageView.builder(
              controller: _pageController,
              itemCount: screens.length,
              onPageChanged: (index) => setState(() => _selectedIndex = index),
              itemBuilder: (context, index) => screens[index],
            ),
      bottomNavigationBar: isWideScreen
          ? null
          : BottomNavigationBar(
              currentIndex: _selectedIndex,
              unselectedItemColor: isLightMode ? semiDarkGrey : lightColor,
              selectedItemColor: isLightMode ? darkGrey : lightColor,
              onTap: (index) => setState(() {
                _selectedIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linearToEaseOut,
                );
              }),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined),
                  activeIcon: Icon(Icons.account_circle),
                  label: 'Profile',
                ),
              ],
            ),
    );
  }

  Future<void> getUserDetails() async => await UserServices.getUser(context);
}
