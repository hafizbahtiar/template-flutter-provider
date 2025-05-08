class UserModel {
  final String? id;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? avatarUrl;
  final String? department;

  // Transient field - not stored in the model's regular state
  // Used only during registration flow
  String? _password;
  String? _confirmPassword;

  UserModel({this.id, this.name, this.firstName, this.lastName, this.email, this.avatarUrl, this.department});

  /// Creates a copy of this UserModel with the given fields replaced
  UserModel copyWith({
    String? id,
    String? name,
    String? firstName,
    String? lastName,
    String? email,
    String? avatarUrl,
    String? department,
    String? graduationYear,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      department: department ?? this.department,
    );
  }

  /// Factory constructor to create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      department: json['department'],
    );
  }

  /// Convert UserModel to JSON for API operations
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'avatar_url': avatarUrl,
      'department': department,
    };
  }

  /// Temporarily set password for registration
  UserModel forRegister(String password, String confirmPassword) {
    final user = copyWith();
    user._password = password;
    user._confirmPassword = confirmPassword;
    return user;
  }

  /// Temporarily set password for login
  UserModel withPassword(String password) {
    final user = copyWith();
    user._password = password;
    return user;
  }

  /// Convert to JSON specifically for registration endpoint
  Map<String, dynamic> toRegisterJson() {
    return {'name': name, 'email': email, 'password': _password, 'confirm_password': _confirmPassword};
  }

  /// Convert to JSON specifically for login endpoint
  Map<String, dynamic> toLoginJson() {
    return {'email': email, 'password': _password};
  }

  /// Check if model has all required fields for registration
  bool get hasRequiredRegistrationFields {
    return id != null &&
        id!.isNotEmpty &&
        email != null &&
        email!.isNotEmpty &&
        _password != null &&
        _password!.isNotEmpty &&
        _confirmPassword != null &&
        _confirmPassword!.isNotEmpty;
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email)';
  }
}
