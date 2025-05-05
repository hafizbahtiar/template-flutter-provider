import 'package:flutter/material.dart';
import 'package:template_flutter_provider/data/entities/user.dart';
import 'package:template_flutter_provider/data/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository userRepository;

  List<User> _users = [];
  List<User> get users => _users;

  UserProvider({required this.userRepository}) {
    loadUsers(); // auto-load on init
  }

  // Add user using the repository
  void addUser(String name, String email) async {
    await userRepository.addUser(name, email);
    loadUsers();
  }

  // Delete user using the repository
  void deleteUser(int id) async {
    await userRepository.deleteUser(id);
    loadUsers();
  }

  // Load all users using the repository
  void loadUsers() {
    _users = userRepository.getAllUsers();
    notifyListeners();
  }
}
