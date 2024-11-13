import 'package:convergeimmob/features/chat/bloc/chat_state.dart';
import 'package:convergeimmob/features/chat/data/models/message_model.dart';
import 'package:convergeimmob/features/chat/data/models/user_model.dart';
import 'package:convergeimmob/features/chat/data/repositories/users_with_last_messages_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersWithLastMessageCubit extends Cubit<ChatState> {
  UsersWithLastMessagesRepository usersWithLastMessageRepository = UsersWithLastMessagesRepository();
  Map<UserModel , MessageModel> usersWithLastMessages = {};

  UsersWithLastMessageCubit() : super(ChatInitial());

  Future<void> getUsersAndLastMessages(String sourceId) async {
    emit(ChatLoading());
    try {
      usersWithLastMessages = await usersWithLastMessageRepository.fetchUsersWithLastMessages(sourceId);
      emit(ChatSuccess());
    } catch (e) {
      emit(ChatError("$e"));
    }
  }
  Future<void> updateLastMessage(String sourceId,String sender, MessageModel newMessage) async {
    emit(ChatLoading());
    try {
      // Find the user with the given senderId
      UserModel? userToUpdate;
      for (var user in usersWithLastMessages.keys) {
        if (user.id == sender) {
          userToUpdate = user;
          break;
        }
      }
      if (userToUpdate != null) {
        usersWithLastMessages[userToUpdate] = newMessage;
        emit(ChatSuccess());
      }
      else {
        usersWithLastMessages = await usersWithLastMessageRepository.fetchUsersWithLastMessages(sourceId);
        emit(ChatUpdated());
      }
    } catch (e) {
      emit(ChatError("$e"));
    }
  }
}
