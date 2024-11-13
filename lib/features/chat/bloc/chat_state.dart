abstract class ChatState {}

class ChatInitial extends ChatState{}

class ChatLoading extends ChatState{}

class ChatSuccess extends ChatState{}

class ChatUpdated extends ChatState{}

class ChatError extends ChatState{
  final String errorMessage;
  ChatError(this.errorMessage);
}