import 'dart:convert';
import 'package:flutter_assessment/app/data/api.dart';
import 'package:flutter_assessment/app/global/utils/request_header.dart';
import 'package:flutter_assessment/app/models/auth.dart';
import 'package:flutter_assessment/app/models/signup_data.dart';
import 'package:flutter_assessment/app/singleton/secure_storage_singleton.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future login(Auth authData) async {
    try {
      final auth = authData.copyWith(
        clientId: '7',
        clientSecret: 'koVJfcKaeSpXOjQtWJkEQxZ5YnJ7r8If5r3Sa2Ro',
        grantType: 'password',
      );

      final response = await http.post(
        Uri.parse(Api.authenticate),
        body: json.encode(auth),
        headers: RequestHeader.getJsonHeader(),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        await SecureStorageSingleton.write('oauth', responseData['access_token']);
        return responseData;
      } else {
        return responseData;
      }
    } catch (e) {
      return {'message': 'Failed to authenticate. Please check your credentials and try again.'};
    }
  }

  static Future signup(SignUpData signUpData) async {
    try {
      final response = await http.post(
        Uri.parse(Api.signUp),
        body: signUpData.toJson(),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        return responseData;
      } else {
        return responseData;
      }
    } catch (e) {
      return {'message': 'Failed to register. Please check your credentials and try again.'};
    }
  }
}
