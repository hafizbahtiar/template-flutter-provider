class User {
  final String id;
  final String email;
  final String name;
  final String? profileImage;
  final String token;
  final DateTime? lastLogin;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.profileImage,
    required this.token,
    this.lastLogin,
  });
}