import 'dart:convert';
import 'package:convergeimmob/constants/app_links.dart';
import 'package:http/http.dart' as http;

class SearchForUsersDataSource {
  Future<List<dynamic>> searchForUsers(String query , String sourceId) async {
    final response = await http.get(Uri.parse('$local/api/chat/search-for-users?q=$query&sourceId=$sourceId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception('User not found');
    }
  }
}