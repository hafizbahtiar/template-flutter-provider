import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:template_flutter_provider/core/api/api_client.dart';

import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';
import '../../domain/entities/user.dart';

class UserRepositoryImpl implements UserRepository {
  final _apiClient = ApiClient();
  final http.Client _client;
  final SharedPreferences _preferences;
  final Logger _logger;
  final String _baseUrl;

  // ignore: constant_identifier_names
  static const String USER_KEY = 'user_data';

  UserRepositoryImpl({required http.Client client, required SharedPreferences preferences, required Logger logger})
    : _client = client,
      _preferences = preferences,
      _logger = logger,
      _baseUrl = dotenv.env['API_URL'] ?? 'https://api.example.com';

  @override
  Future<User?> login(String email, String password) async {
    try {
      final response = await _apiClient.post(
        '/auth/login',
        requiresAuth: false,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        final user = UserModel.fromJson(userData);

        // Save user to local storage
        await _saveUser(user);

        return user;
      } else {
        _logger.e('Login failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.e('Login error: $e');
      return null;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      // Clear local storage
      await _preferences.remove(USER_KEY);
      return true;
    } catch (e) {
      _logger.e('Logout error: $e');
      return false;
    }
  }

  @override
  Future<User?> register(String name, String email, String password) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/auth/register'),
        body: json.encode({'name': name, 'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        final userData = json.decode(response.body);
        final user = UserModel.fromJson(userData);

        // Save user to local storage
        await _saveUser(user);

        return user;
      } else {
        _logger.e('Registration failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.e('Registration error: $e');
      return null;
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final userString = _preferences.getString(USER_KEY);
      if (userString != null) {
        return UserModel.fromJson(json.decode(userString));
      }
      return null;
    } catch (e) {
      _logger.e('Get current user error: $e');
      return null;
    }
  }

  Future<void> _saveUser(UserModel user) async {
    await _preferences.setString(USER_KEY, json.encode(user.toJson()));
  }
}
