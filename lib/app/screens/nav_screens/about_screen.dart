import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/global/constants/app_constants.dart';
import 'package:flutter_assessment/app/models/app_info.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _aboutDetails(title: 'App Name', details: aboutAppInfo.appName),
              _aboutDetails(title: 'Version', details: aboutAppInfo.version),
              _aboutDetails(title: 'Description', details: aboutAppInfo.description),
              _aboutDetails(title: 'Developer', details: aboutAppInfo.developer),
              _aboutDetails(title: 'Contact Email', details: aboutAppInfo.contactEmail),
            ],
          ),
        ),
      ),
    );
  }

  Widget _aboutDetails({
    required String title,
    required String details,
    bool isLast = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppConstants.titleTextStyle()),
        Text(details, style: AppConstants.bodyTextStyle()),
        if (!isLast) const SizedBox(height: 16),
      ],
    );
  }
}
