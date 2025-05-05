import 'package:flutter/material.dart';

enum SignInState { initial, loading, success, error }

class SignInProvider extends ChangeNotifier {
  SignInState _state = SignInState.initial;
  String _errorMessage = '';
  bool _rememberMe = true;
  bool _obscurePassword = true;

  // Getters
  SignInState get state => _state;
  String get errorMessage => _errorMessage;
  bool get rememberMe => _rememberMe;
  bool get obscurePassword => _obscurePassword;
  bool get isLoading => _state == SignInState.loading;

  // Methods to update state
  void toggleRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void resetError() {
    if (_errorMessage.isNotEmpty) {
      _errorMessage = '';
      notifyListeners();
    }
  }

  // Sign in method
  Future<bool> signIn(String email, String password) async {
    // Reset any previous errors
    _errorMessage = '';

    // Set state to loading
    _state = SignInState.loading;
    notifyListeners();

    try {
      // Simulate network delay for demonstration
      await Future.delayed(const Duration(seconds: 2));

      // Here you would implement your actual authentication logic
      // For example with Supabase, Firebase, or your custom auth service
      // Example:
      // final response = await _authService.signIn(email, password);

      // For demonstration, let's use dummy validation
      if (email == 'test@example.com' && password == 'Password123') {
        _state = SignInState.success;
        notifyListeners();
        return true;
      } else {
        _state = SignInState.error;
        _errorMessage = 'Invalid email or password';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _state = SignInState.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Password reset request
  Future<bool> requestPasswordReset(String email) async {
    try {
      // Set loading state (locally for this operation)
      notifyListeners();

      // Simulate network request
      await Future.delayed(const Duration(seconds: 1));

      // Here you would implement your actual password reset logic
      // Example:
      // await _authService.resetPasswordForEmail(email);

      return true;
    } catch (e) {
      return false;
    }
  }
}
