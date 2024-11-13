import 'package:convergeimmob/features/chat/data/datasources/previous_messages_data_source.dart';
import 'package:convergeimmob/features/chat/data/models/message_model.dart';

class PreviousMessagesRepository {

  final PreviousMessagesDataSource previousMessagesDataSource = PreviousMessagesDataSource() ;

  PreviousMessagesRepository();

  Future<List<MessageModel>> fetchPreviousMessages(String sourceId, String destinationId) async {
    try{
      final jsonData = await previousMessagesDataSource.getPreviousMessages(sourceId, destinationId);
      if (jsonData.isEmpty) {
        return [];
      }
      List<MessageModel> messages = (jsonData).map((messageJson) {
        MessageModel message = MessageModel.fromJson(messageJson);
        message.type = (message.sender == sourceId) ? "source" : "destination";
        return message;
      }).toList();
      return messages;
    }
    catch (e) {
      throw Exception('Failed to load messages');
    }
  }
}