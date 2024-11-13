class UserModel {
  String? id ;
  String? firstName ;
  String? profilePicture ;
  UserModel({
    required this.id ,
    required this.profilePicture ,
    required this.firstName
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        id: json['_id'],
        profilePicture: json['profilePicture'],
        firstName:json['firstName']
    );
  }

}