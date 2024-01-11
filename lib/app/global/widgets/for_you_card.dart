import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/global/constants/app_constants.dart';

class ForYouCard extends StatelessWidget {
  final Color? color;
  final String title;

  const ForYouCard({
    super.key,
    this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.zero,
            surfaceTintColor: Colors.transparent,
            child: Container(
              width: double.maxFinite,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: AppConstants.semiTitleTextStyle(),
          maxLines: 2,
        ),
      ],
    );
  }
}
