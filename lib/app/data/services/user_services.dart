import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/data/api.dart';
import 'package:flutter_assessment/app/global/utils/request_header.dart';
import 'package:flutter_assessment/app/models/user.dart';
import 'package:flutter_assessment/app/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UserServices {
  static Future<void> getUser(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse(Api.getUserDetails),
        headers: await RequestHeader.getJsonHeaderAccessToken(),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        if (context.mounted) {
          final provider = Provider.of<UserProvider>(context, listen: false);
          provider.user = User.fromJson(responseData);
        }
        return;
      } else {
        return;
      }
    } catch (e) {
      return;
    }
  }
}
