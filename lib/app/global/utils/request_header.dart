import 'package:flutter_assessment/app/singleton/secure_storage_singleton.dart';

class RequestHeader {
  static Map<String, String> getJsonHeader() {
    return {"Content-Type": "application/json", "Accept": "application/json"};
  }

  static Future<Map<String, String>?> getJsonHeaderAccessToken() async {
    final oauthToken = await SecureStorageSingleton.read('oauth');
    if (oauthToken != null) {
      return {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $oauthToken",
      };
    }

    return null;
  }
}
