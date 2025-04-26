import '../entities/user.dart';
import '../repositories/user_repository.dart';

class RegisterUseCase {
  final UserRepository _repository;

  RegisterUseCase(this._repository);

  Future<User?> execute(String name, String email, String password) {
    return _repository.register(name, email, password);
  }
}
