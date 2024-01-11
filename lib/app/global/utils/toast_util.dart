import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/global/constants/colors.dart';
import 'package:flutter_assessment/app/providers/theme_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ToastUtil {
  static showToast(BuildContext context, String message) {
    final provider = context.read<ThemeProvider>();
    return Fluttertoast.showToast(
      msg: message,
      backgroundColor: provider.isDarkMode ? semiLightColor : semiDarkGrey,
      webBgColor: provider.isDarkMode ? '#F1F0EC' : '#E3F2FD',
      textColor: provider.isDarkMode ? Colors.black : Colors.white,
    );
  }
}
