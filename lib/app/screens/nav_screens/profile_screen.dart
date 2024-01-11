import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/global/constants/app_constants.dart';
import 'package:flutter_assessment/app/global/constants/colors.dart';
import 'package:flutter_assessment/app/providers/theme_provider.dart';
import 'package:flutter_assessment/app/providers/user_provider.dart';
import 'package:flutter_assessment/app/routes/route_names.dart';
import 'package:flutter_assessment/app/singleton/secure_storage_singleton.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                Consumer<UserProvider>(
                  builder: (context, userProvider, child) => Row(
                    children: [
                      Consumer<ThemeProvider>(
                        builder: (context, themeProvider, child) => _circleAvatarInitials(
                          name: userProvider.user?.name ?? '',
                          isDarkMode: themeProvider.isDarkMode,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userProvider.user?.name ?? 'NAME',
                              style: AppConstants.bodyTextStyle(),
                            ),
                            Text(
                              userProvider.user?.email ?? 'EMAIL',
                              style: AppConstants.bodyTextStyle(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  surfaceTintColor: Colors.transparent,
                  color: Theme.of(context).canvasColor,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _menuButton(
                        icon: Icons.settings,
                        label: 'Settings',
                        onTap: () => context.push(settingScreen),
                      ),
                      const Divider(height: 1, thickness: 1, indent: 16, endIndent: 16),
                      _menuButton(
                        icon: Icons.info,
                        label: 'About Us',
                        onTap: () => context.push(aboutScreen),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  surfaceTintColor: Colors.transparent,
                  color: Theme.of(context).canvasColor,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _menuButton(
                        icon: Icons.logout,
                        label: 'Logout',
                        onTap: logout,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logout() async {
    final provider = context.read<UserProvider>();

    provider.user = null;
    await SecureStorageSingleton.delete('oauth');

    if (context.mounted) context.go(loginScreen);
  }

  Widget _circleAvatarInitials({required String name, required bool isDarkMode}) {
    String initial = name.isNotEmpty ? name[0].toUpperCase() : "?";
    return CircleAvatar(
      radius: 48,
      foregroundColor: isDarkMode ? darkGrey : lightColor,
      backgroundColor: isDarkMode ? lightColor : darkGrey,
      child: Text(initial, style: AppConstants.titleTextStyle(fontsize: 32)),
    );
  }

  Widget _menuButton({
    required void Function()? onTap,
    required IconData icon,
    required String label,
  }) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
