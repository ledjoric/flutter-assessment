class AppInfo {
  final String appName;
  final String version;
  final String description;
  final String developer;
  final String contactEmail;

  AppInfo({
    required this.appName,
    required this.version,
    required this.description,
    required this.developer,
    required this.contactEmail,
  });
}

final aboutAppInfo = AppInfo(
  appName: 'Lorem Ipsum App',
  version: '1.0.0',
  description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  developer: 'Lorem Ipsum Inc.',
  contactEmail: 'lorem@ipsum.com',
);
