import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
    super.profileImage,
    required super.token,
    super.lastLogin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      profileImage: json['profile_image'],
      token: json['token'],
      lastLogin: json['last_login'] != null ? DateTime.parse(json['last_login']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profile_image': profileImage,
      'token': token,
      'last_login': lastLogin?.toIso8601String(),
    };
  }

  factory UserModel.fromUser(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      profileImage: user.profileImage,
      token: user.token,
      lastLogin: user.lastLogin,
    );
  }
}
