import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:mobile_application/Services/config.dart';
import 'package:mobile_application/events/message_response.dart';
import 'package:mobile_application/events/send_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MesssagingHelper {
  static https.Client client = https.Client();

 
  static Future<List<dynamic>> sendMessage(SendMessage model) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'token': 'Bearer $token',
    };

    final url = Uri.http(Config.apiUrl, Config.messagingUrl);
    final response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      ReceivedMessge message = ReceivedMessge.fromJson(jsonDecode(response.body));

      final Map<String, dynamic> responseMap = jsonDecode(response.body);
      return [true, message, responseMap];
    } else {
      return [false];
    }
  }


  static Future<List<ReceivedMessge>> getMessages(
    String chatId,
    int offset,
  ) async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final requestHeaders = <String, String>{
        'Content-Type': 'application/json',
        'token': 'Bearer $token',
      };

      final url = Uri.http(
        Config.apiUrl,
        '${Config.messagingUrl}/$chatId',
        {'page': offset.toString()},
      );
      final response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        final messages = receivedMessgeFromJson(response.body);

        return messages;
      } else {
        throw Exception(' failed to load messages');
      }
    
  }
}
