import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../data/repositories/user_repository_impl.dart';

enum AuthStatus { initial, authenticated, unauthenticated, loading, error }

class AuthProvider with ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final Logger _logger;

  User? _currentUser;
  AuthStatus _status = AuthStatus.initial;
  String _errorMessage = '';

  AuthProvider({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required Logger logger,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       _logoutUseCase = logoutUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       _logger = logger;

  User? get currentUser => _currentUser;
  AuthStatus get status => _status;
  String get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  Future<void> initialize() async {
    try {
      _status = AuthStatus.loading;
      notifyListeners();

      final user = await _getCurrentUserUseCase.execute();

      if (user != null) {
        _currentUser = user;
        _status = AuthStatus.authenticated;
      } else {
        _status = AuthStatus.unauthenticated;
      }
    } catch (e) {
      _logger.e('Auth initialization error: $e');
      _status = AuthStatus.error;
      _errorMessage = 'Failed to initialize authentication';
    } finally {
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      _status = AuthStatus.loading;
      _errorMessage = '';
      notifyListeners();

      final user = await _loginUseCase.execute(email, password);

      if (user != null) {
        _currentUser = user;
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      } else {
        _status = AuthStatus.unauthenticated;
        _errorMessage = 'Invalid email or password';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _logger.e('Login error: $e');
      _status = AuthStatus.error;
      _errorMessage = 'Login failed: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      _status = AuthStatus.loading;
      _errorMessage = '';
      notifyListeners();

      final user = await _registerUseCase.execute(name, email, password);

      if (user != null) {
        _currentUser = user;
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      } else {
        _status = AuthStatus.unauthenticated;
        _errorMessage = 'Registration failed';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _logger.e('Registration error: $e');
      _status = AuthStatus.error;
      _errorMessage = 'Registration failed: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      _status = AuthStatus.loading;
      notifyListeners();

      final result = await _logoutUseCase.execute();

      if (result) {
        _currentUser = null;
        _status = AuthStatus.unauthenticated;
        notifyListeners();
        return true;
      } else {
        _status = AuthStatus.error;
        _errorMessage = 'Logout failed';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _logger.e('Logout error: $e');
      _status = AuthStatus.error;
      _errorMessage = 'Logout failed: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  // Factory method to easily create the provider with all dependencies
  static Future<AuthProvider> create() {
    final client = http.Client();
    final logger = Logger();

    // This would typically be done with proper dependency injection
    // For simplicity, we're creating dependencies inline
    return SharedPreferences.getInstance().then((preferences) {
      final repository = UserRepositoryImpl(client: client, preferences: preferences, logger: logger);

      return AuthProvider(
        loginUseCase: LoginUseCase(repository),
        registerUseCase: RegisterUseCase(repository),
        logoutUseCase: LogoutUseCase(repository),
        getCurrentUserUseCase: GetCurrentUserUseCase(repository),
        logger: logger,
      );
    });
  }
}
