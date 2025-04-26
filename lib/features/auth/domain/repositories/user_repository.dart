import '../entities/user.dart';

abstract class UserRepository {
  Future<User?> login(String email, String password);
  Future<User?> register(String name, String email, String password);
  Future<bool> logout();
  Future<User?> getCurrentUser();
}
