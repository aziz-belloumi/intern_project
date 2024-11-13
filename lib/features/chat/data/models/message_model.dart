class MessageModel {
  String? type ;
  String? message ;
  String? timestamp ;
  bool? isRead ;
  String? sender ;
  String? receiver ;
  MessageModel({
    required this.type ,
    required this.message ,
    required this.timestamp ,
    required this.isRead ,
    required this.sender ,
    required this.receiver
  });
   factory MessageModel.fromJson(Map<String , dynamic> json){
     return MessageModel(
         type: null ,
         message: json['message'],
         timestamp: json['timestamp'],
         isRead: json['isRead'],
         sender: json['sender'],
         receiver: json['receiver']
     );
   }
}