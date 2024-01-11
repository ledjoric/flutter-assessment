import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifs = false;
  bool _messageNotif = false;
  bool _newsAndUpdatesNotifs = false;
  bool _reminderNotifs = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _settingSection(
                label: 'THEME',
                children: [
                  Consumer<ThemeProvider>(
                    builder: (context, provider, child) => _switchMenuItem(
                      onChanged: (value) => provider.toggleTheme(value),
                      value: provider.isDarkMode,
                      label: 'Dark Mode',
                      icon: Icons.brightness_6,
                    ),
                  ),
                ],
              ),
              // FOR EXTRA CONTENT
              _settingSection(label: 'NOTIFICATIONS', children: [
                _switchMenuItem(
                  onChanged: (value) => setState(() => _pushNotifs = value),
                  value: _pushNotifs,
                  label: 'Push Notification',
                  icon: Icons.notifications_on,
                ),
                const Divider(height: 1, thickness: 1, indent: 16, endIndent: 16),
                _switchMenuItem(
                  onChanged: !_pushNotifs ? null : (value) => setState(() => _messageNotif = value),
                  value: _messageNotif,
                  label: 'Messages',
                  icon: Icons.message,
                ),
                const Divider(height: 1, thickness: 1, indent: 16, endIndent: 16),
                _switchMenuItem(
                  onChanged: !_pushNotifs ? null : (value) => setState(() => _newsAndUpdatesNotifs = value),
                  value: _newsAndUpdatesNotifs,
                  label: 'News and Updates',
                  icon: Icons.newspaper,
                ),
                const Divider(height: 1, thickness: 1, indent: 16, endIndent: 16),
                _switchMenuItem(
                  onChanged: !_pushNotifs ? null : (value) => setState(() => _reminderNotifs = value),
                  value: _reminderNotifs,
                  label: 'Reminders',
                  icon: Icons.note_alt,
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingSection({
    required String label,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 4),
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Card(
            surfaceTintColor: Colors.transparent,
            color: Theme.of(context).canvasColor,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.zero,
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _switchMenuItem({
    required void Function(bool)? onChanged,
    required bool value,
    required String label,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
