import 'package:template_flutter_provider/data/entities/user.dart';
import '../objectbox/objectbox.g.dart';

class UserService {
  final Store store;

  UserService(this.store);

  // Add a new user
  Future<void> addUser(String name, String email) async {
    final user = User(name: name, email: email);
    store.box<User>().put(user);
  }

  // Get all users
  List<User> getAllUsers() {
    final box = store.box<User>();
    return box.getAll();
  }

  // Get user by ID
  User? getUserById(int id) {
    final box = store.box<User>();
    return box.get(id);
  }

  // Update a user
  Future<void> updateUser(User user) async {
    final box = store.box<User>();
    box.put(user);
  }

  // Delete a user
  Future<void> deleteUser(int id) async {
    final box = store.box<User>();
    box.remove(id);
  }
}
