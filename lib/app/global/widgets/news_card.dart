import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/global/constants/app_constants.dart';

class NewsCard extends StatelessWidget {
  final Color? color;
  final String title;
  final bool isWideScreen;

  const NewsCard({
    super.key,
    this.color,
    required this.title,
    required this.isWideScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.zero,
      child: SizedBox(
        height: 50,
        width: double.maxFinite,
        child: Row(
          children: [
            Card(
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.zero,
              child: Container(
                color: color,
                width: isWideScreen ? 1000 / 8.5 : MediaQuery.of(context).size.height / 8.5,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        title,
                        maxLines: 2,
                        style: AppConstants.titleTextStyle(),
                      ),
                    ),
                    const Text('Technology  12 hrs ago'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
