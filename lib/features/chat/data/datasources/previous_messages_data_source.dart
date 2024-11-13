import 'dart:convert';
import 'package:convergeimmob/constants/app_links.dart';
import 'package:http/http.dart' as http;

class PreviousMessagesDataSource {
  Future<List<dynamic>> getPreviousMessages(String sourceId, String destinationId) async {
    final response = await http.get(Uri.parse("$local/api/chat/messages?sourceId=$sourceId&destinationId=$destinationId"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception('Backend error');
    }
  }
}
