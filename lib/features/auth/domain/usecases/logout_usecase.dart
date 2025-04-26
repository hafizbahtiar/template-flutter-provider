import '../repositories/user_repository.dart';

class LogoutUseCase {
  final UserRepository _repository;

  LogoutUseCase(this._repository);

  Future<bool> execute() {
    return _repository.logout();
  }
}
