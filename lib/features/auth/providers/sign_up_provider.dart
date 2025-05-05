import 'package:flutter/material.dart';

enum SignUpState { initial, loading, success, error }

class SignUpProvider extends ChangeNotifier {
  SignUpState _state = SignUpState.initial;
  String _errorMessage = '';
  bool _agreeToTerms = false;
  bool _obscurePassword = true;

  // Getters
  SignUpState get state => _state;
  String get errorMessage => _errorMessage;
  bool get agreeToTerms => _agreeToTerms;
  bool get obscurePassword => _obscurePassword;
  bool get isLoading => _state == SignUpState.loading;

  // Methods to update state
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleTermsAgreement(bool value) {
    _agreeToTerms = value;
    notifyListeners();
  }

  void resetError() {
    if (_errorMessage.isNotEmpty) {
      _errorMessage = '';
      notifyListeners();
    }
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Sign in method
  Future<bool> signUp({required String name, required String email, required String password}) async {
    // Reset any previous errors
    resetError();

    // Set state to loading
    _state = SignUpState.loading;
    notifyListeners();

    try {
      // Simulate network delay for demonstration
      await Future.delayed(const Duration(seconds: 2));

      // Simulate success if email doesn't contain "fail"
      if (email.contains('fail')) {
        throw Exception('Registration failed. Email might already be in use.');
      }

      // Set state to success
      _state = SignUpState.success;
      notifyListeners();
      return true;
    } catch (e) {
      // Handle error and update state
      _state = SignUpState.error;
      _errorMessage = 'An error occurred during registration: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }
}
