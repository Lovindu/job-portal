import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:mobile_application/Services/config.dart';
import 'package:mobile_application/events/login_model.dart';
import 'package:mobile_application/events/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = https.Client();

  static Future<bool> login(LoginModel model) async {
    
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };
      var url = Uri.https(Config.apiUrl, Config.loginUrl);
      var response = await client.post(url,
          headers: requestHeaders, body: jsonEncode(model));

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        String token = loginResponseModelFromJson(response.body).userToken;
        String userId = loginResponseModelFromJson(response.body).id;
        String profile = loginResponseModelFromJson(response.body).profile;

        await prefs.setString('token', token);
        await prefs.setString('userId', userId);
        await prefs.setString('profile', profile);
        await prefs.setBool('loggedIn', true);

        return true;
      } else {
        return false;
      }
  }
static Future<bool> signup(model) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };
      var url = Uri.https(Config.apiUrl, Config.signupUrl);
      var response =
          await client.post(url, headers: requestHeaders, body: model);

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  
}
