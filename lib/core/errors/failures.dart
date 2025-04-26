class Failure {
  final String message;
  final int? code;

  Failure({required this.message, this.code});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, super.code});
}

class CacheFailure extends Failure {
  CacheFailure({required super.message}) : super(code: null);
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message}) : super(code: null);
}

class AuthFailure extends Failure {
  AuthFailure({required super.message, super.code});
}
