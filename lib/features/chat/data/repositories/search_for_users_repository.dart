import 'package:convergeimmob/features/chat/data/datasources/search_for_users_data_source.dart';
import 'package:convergeimmob/features/chat/data/models/user_model.dart';

class SearchForUsersRepository {

  final SearchForUsersDataSource searchForUsersDataSource = SearchForUsersDataSource() ;

  Future<List<UserModel>> fetchUsers(String query , String sourceId) async {
    try{
      final jsonData = await searchForUsersDataSource.searchForUsers(query , sourceId);
      if (jsonData.isEmpty) {
        return [];
      }
      List<UserModel> foundedUsers = (jsonData).map((userJson) {
        UserModel user = UserModel.fromJson(userJson);
        return user;
      }).toList();
      return foundedUsers;
    }
    catch (e) {
      throw Exception('Failed to load users');
    }
  }
}