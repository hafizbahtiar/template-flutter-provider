import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetCurrentUserUseCase {
  final UserRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<User?> execute() {
    return _repository.getCurrentUser();
  }
}
