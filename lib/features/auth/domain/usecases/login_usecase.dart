import '../entities/user.dart';
import '../repositories/user_repository.dart';

class LoginUseCase {
  final UserRepository _repository;

  LoginUseCase(this._repository);

  Future<User?> execute(String email, String password) {
    return _repository.login(email, password);
  }
}
