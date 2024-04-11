import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:mobile_application/Services/config.dart';
import 'package:mobile_application/events/create_chat.dart';
import 'package:mobile_application/events/get_chat.dart';
import 'package:mobile_application/events/initial_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatHelper {
  static https.Client client = https.Client();


  static Future<List<dynamic>> apply(CreateChat model) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'token': 'Bearer $token',
    };

    final url = Uri.http(Config.apiUrl, Config.chatsUrl);
    final response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      final first = initialChatFromJson(response.body).id;

      return [true, first];
    } else {
      return [false];
    }
  }

  static Future<List<GetChats>> getConversations() async {

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
        'token': 'Bearer $token',
      };

      final url = Uri.http(Config.apiUrl, Config.chatsUrl);
      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        final chats = getChatsFromJson(response.body);

        return chats;
      } else {
        throw Exception("Couldn't load chats");
      }
    
  }
}
