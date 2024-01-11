import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/global/constants/app_constants.dart';
import 'package:flutter_assessment/app/global/constants/colors.dart';

class CarouselItem extends StatelessWidget {
  final Color? color;
  final bool isDarkMode;
  final String title;

  const CarouselItem({
    super.key,
    this.color,
    required this.isDarkMode,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 125,
        width: double.maxFinite,
        color: isDarkMode ? darkGrey.withOpacity(0.5) : lightColor.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  style: AppConstants.titleTextStyle(),
                ),
              ),
              const Text('Technology  12 hrs ago'),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
