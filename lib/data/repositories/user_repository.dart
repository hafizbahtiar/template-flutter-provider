import 'package:template_flutter_provider/data/entities/user.dart';
import 'package:template_flutter_provider/data/services/user_service.dart';

class UserRepository {
  final UserService userService;

  UserRepository(this.userService);

  // Add a new user
  Future<void> addUser(String name, String email, {String currency = "USD", String language = "en"}) async {
    try {
      final user = User(name: name, email: email, currency: currency, language: language);
      await userService.addUser(user.name, user.email);
    } catch (e) {
      rethrow; // Propagate the error if needed, or handle it accordingly.
    }
  }

  // Get all users
  List<User> getAllUsers() {
    try {
      return userService.getAllUsers();
    } catch (e) {
      rethrow; // Propagate the error if needed
    }
  }

  // Get user by ID
  User? getUserById(int id) {
    try {
      return userService.getUserById(id);
    } catch (e) {
      rethrow; // Propagate the error if needed
    }
  }

  // Delete a user
  Future<void> deleteUser(int id) async {
    try {
      await userService.deleteUser(id);
    } catch (e) {
      rethrow; // Propagate the error if needed
    }
  }
}
