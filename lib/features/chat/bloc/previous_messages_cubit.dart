import 'package:convergeimmob/features/chat/bloc/chat_state.dart';
import 'package:convergeimmob/features/chat/data/models/message_model.dart';
import 'package:convergeimmob/features/chat/data/repositories/previous_messages_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviousMessagesCubit extends Cubit<ChatState> {
  PreviousMessagesRepository previousMessagesRepository = PreviousMessagesRepository();
  List<MessageModel> messages =[];

  PreviousMessagesCubit():super(ChatInitial());

  Future<void> getPreviousMessages(String sourceId , String destinationId) async {
    emit(ChatLoading());
    try{
      messages = await previousMessagesRepository.fetchPreviousMessages(sourceId, destinationId);
      emit(ChatSuccess());
    }
    catch (e) {
      emit(ChatError("$e"));
    }
  }
}