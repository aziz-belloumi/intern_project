import 'package:convergeimmob/features/chat/data/datasources/users_with_last_messages_data_source.dart';
import 'package:convergeimmob/features/chat/data/models/message_model.dart';
import 'package:convergeimmob/features/chat/data/models/user_model.dart';

class UsersWithLastMessagesRepository {

  final UsersWithLastMessagesDataSource usersWithLastMessagesDataSource = UsersWithLastMessagesDataSource();

  UsersWithLastMessagesRepository();

  Future<Map<UserModel,MessageModel>> fetchUsersWithLastMessages(String sourceId) async {
    try {
      final jsonData = await usersWithLastMessagesDataSource.getUsersAndLastMessages(sourceId);
      Map<UserModel, MessageModel> usersWithLastMessages = {};
      for (var item in jsonData) {
        UserModel user = UserModel.fromJson(item);
        MessageModel message = MessageModel.fromJson(item);
        usersWithLastMessages[user] = message;
      }
      return usersWithLastMessages ;
    }
    catch (e) {
      throw Exception('Failed to fetch users with last messages');
    }
  }
}
