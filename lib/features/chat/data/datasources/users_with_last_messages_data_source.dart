import 'dart:convert';
import 'package:convergeimmob/constants/app_links.dart';
import 'package:http/http.dart' as http;

class UsersWithLastMessagesDataSource {
  Future<List<dynamic>> getUsersAndLastMessages(String sourceId) async {
    final response = await http.get(Uri.parse("$local/api/chat/last-messages?userId=$sourceId"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception('Backend error');
    }
  }
}