// lib/core/api/api_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_flutter_provider/core/constants/shared_prefs_name.dart';

/// A singleton class that centralizes all API requests for the application.
class ApiClient {
  // Singleton instance
  static ApiClient? _instance;

  // Base URL for API requests
  final String baseUrl;

  // HTTP client
  final http.Client _client;

  // Logger instance
  final Logger _logger;

  // Timeout duration for requests
  final Duration _timeout;

  // Shared preferences for token storage
  final Future<SharedPreferences> _sharedPrefs = SharedPreferences.getInstance();

  // Private constructor
  ApiClient._({
    required this.baseUrl,
    required http.Client client,
    required Logger logger,
    Duration timeout = const Duration(seconds: 30),
  }) : _client = client,
       _logger = logger,
       _timeout = timeout;

  /// Factory constructor to get the singleton instance
  factory ApiClient({
    http.Client? client,
    Logger? logger,
    String? baseUrl,
    Duration timeout = const Duration(seconds: 30),
  }) {
    _instance ??= ApiClient._(
      baseUrl: baseUrl ?? dotenv.env['API_URL'] ?? 'https://api.example.com',
      client: client ?? http.Client(),
      logger: logger ?? Logger(),
      timeout: timeout,
    );
    return _instance!;
  }

  /// Get the authorization token from shared preferences
  Future<String?> get _authToken async {
    final prefs = await _sharedPrefs;
    return prefs.getString(SharedPrefsName.token);
  }

  /// Set the authorization token in shared preferences
  Future<void> setAuthToken(String token) async {
    final prefs = await _sharedPrefs;
    await prefs.setString(SharedPrefsName.token, token);
  }

  /// Clear the authorization token from shared preferences
  Future<void> clearAuthToken() async {
    final prefs = await _sharedPrefs;
    await prefs.remove(SharedPrefsName.token);
  }

  /// Build headers for requests with customizable options
  Map<String, String> _buildHeaders({bool requiresAuth = true, Map<String, String>? additionalHeaders}) {
    final headers = {'Content-Type': 'application/json', 'Accept': 'application/json'};

    if (requiresAuth) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    // Add any additional headers if provided
    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  /// Handle API response and error logging
  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = response.body;

    _logger.d('Response: $statusCode - $responseBody');

    if (statusCode >= 200 && statusCode < 300) {
      if (responseBody.isEmpty) return null;
      return json.decode(responseBody);
    } else {
      _logger.e('API Error: $statusCode - $responseBody');
      throw ApiException(statusCode: statusCode, message: _parseErrorMessage(responseBody), rawResponse: responseBody);
    }
  }

  /// Parse error message from response body
  String _parseErrorMessage(String responseBody) {
    try {
      final errorJson = json.decode(responseBody);
      // Try multiple common error message fields
      return errorJson['message'] ??
          errorJson['error'] ??
          errorJson['error_message'] ??
          errorJson['errorMessage'] ??
          'Unknown error';
    } catch (e) {
      return responseBody.isNotEmpty ? responseBody : 'Unknown error';
    }
  }

  /// Perform a GET request
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    bool requiresAuth = true,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);

      _logger.d('GET request to: $uri');

      final requestHeaders = _buildHeaders(requiresAuth: requiresAuth, additionalHeaders: headers);

      _logger.d('Headers: $requestHeaders');

      final response = await _client.get(uri, headers: requestHeaders).timeout(_timeout);

      return _handleResponse(response);
    } catch (e) {
      _logger.e('GET request failed: $e');
      rethrow;
    }
  }

  /// Perform a POST request
  Future<dynamic> post(String endpoint, {Object? body, bool requiresAuth = true, Map<String, String>? headers}) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');

      _logger.d('POST request to: $uri');

      final requestHeaders = _buildHeaders(requiresAuth: requiresAuth, additionalHeaders: headers);

      _logger.d('Headers: $requestHeaders');

      if (body != null) {
        _logger.d('Body: ${json.encode(body)}');
      }

      final response = await _client
          .post(uri, headers: requestHeaders, body: body != null ? json.encode(body) : null)
          .timeout(_timeout);

      return _handleResponse(response);
    } catch (e) {
      _logger.e('POST request failed: $e');
      rethrow;
    }
  }

  /// Perform a PUT request
  Future<dynamic> put(String endpoint, {Object? body, bool requiresAuth = true, Map<String, String>? headers}) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');

      _logger.d('PUT request to: $uri');

      final requestHeaders = _buildHeaders(requiresAuth: requiresAuth, additionalHeaders: headers);

      _logger.d('Headers: $requestHeaders');

      if (body != null) {
        _logger.d('Body: ${json.encode(body)}');
      }

      final response = await _client
          .put(uri, headers: requestHeaders, body: body != null ? json.encode(body) : null)
          .timeout(_timeout);

      return _handleResponse(response);
    } catch (e) {
      _logger.e('PUT request failed: $e');
      rethrow;
    }
  }

  /// Perform a PATCH request
  Future<dynamic> patch(String endpoint, {Object? body, bool requiresAuth = true, Map<String, String>? headers}) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');

      _logger.d('PATCH request to: $uri');

      final requestHeaders = _buildHeaders(requiresAuth: requiresAuth, additionalHeaders: headers);

      _logger.d('Headers: $requestHeaders');

      if (body != null) {
        _logger.d('Body: ${json.encode(body)}');
      }

      final response = await _client
          .patch(uri, headers: requestHeaders, body: body != null ? json.encode(body) : null)
          .timeout(_timeout);

      return _handleResponse(response);
    } catch (e) {
      _logger.e('PATCH request failed: $e');
      rethrow;
    }
  }

  /// Perform a DELETE request
  Future<dynamic> delete(
    String endpoint, {
    Object? body,
    bool requiresAuth = true,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');

      _logger.d('DELETE request to: $uri');

      final requestHeaders = _buildHeaders(requiresAuth: requiresAuth, additionalHeaders: headers);

      _logger.d('Headers: $requestHeaders');

      final response = await _client
          .delete(uri, headers: requestHeaders, body: body != null ? json.encode(body) : null)
          .timeout(_timeout);

      return _handleResponse(response);
    } catch (e) {
      _logger.e('DELETE request failed: $e');
      rethrow;
    }
  }

  /// Perform a multipart request for file uploads
  Future<dynamic> multipartRequest(
    String endpoint, {
    required String method,
    Map<String, String>? fields,
    Map<String, http.MultipartFile>? files,
    bool requiresAuth = true,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');

      // Create multipart request
      final request = http.MultipartRequest(method, uri);

      // Add auth header if needed (don't include Content-Type as it's set by MultipartRequest)
      final requestHeaders = _buildHeaders(requiresAuth: requiresAuth, additionalHeaders: headers);
      // Remove Content-Type as it will be set by the MultipartRequest
      requestHeaders.remove('Content-Type');

      // Add headers
      request.headers.addAll(requestHeaders);

      // Add text fields if any
      if (fields != null) {
        request.fields.addAll(fields);
      }

      // Add files if any
      if (files != null) {
        request.files.addAll(files.values);
      }

      _logger.d('${method.toUpperCase()} MULTIPART request to: $uri');
      _logger.d('Headers: ${request.headers}');
      _logger.d('Fields: ${request.fields}');
      _logger.d('Files: ${request.files.length}');

      // Send request
      final streamedResponse = await request.send().timeout(_timeout);

      // Convert to normal response
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response);
    } catch (e) {
      _logger.e('MULTIPART request failed: $e');
      rethrow;
    }
  }

  /// Cancel all pending requests and close the client
  void dispose() {
    _client.close();
  }

  /// Reset singleton instance (useful for testing)
  static void reset() {
    _instance = null;
  }
}

/// Exception thrown when an API request fails
class ApiException implements Exception {
  final int statusCode;
  final String message;
  final String rawResponse;

  ApiException({required this.statusCode, required this.message, this.rawResponse = ''});

  @override
  String toString() => 'ApiException: $statusCode - $message';
}

// Usage example in a main.dart or initialization file:
/*
Future<void> initializeApiClient() async {
  // Load env variables first
  await dotenv.load(fileName: ".env");
  
  final sharedPreferences = await SharedPreferences.getInstance();
  final apiClient = ApiClient(
    preferences: sharedPreferences,
    logger: Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        lineLength: 80,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
    ),
  );
  
  // Example of global access through GetIt or similar
  // GetIt.I.registerSingleton<ApiClient>(apiClient);
}

// Example of making a request with custom headers
final response = await apiClient.get(
  '/users/profile',
  headers: {
    'X-API-Version': '1.0',
    'X-Custom-Header': 'value'
  }
);
*/
