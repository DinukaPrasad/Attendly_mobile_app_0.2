import '../api/api_client.dart';
import '../api/api_endpoints.dart';
import '../api/api_exception.dart';
import '../api/api_response.dart';
import '../api/token_storage.dart';
import '../models/auth_models.dart';

/// Handles authentication API calls (login, register).
class AuthRepository {
  AuthRepository._();

  /// POST /api/v1/auth/login
  ///
  /// On success the backend returns:
  /// ```json
  /// { "success": true, "message": "...", "data": { "token": "...", "role": "..." } }
  /// ```
  /// Stores the JWT automatically via [TokenStorage].
  static Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await ApiClient.dio.post(
        ApiEndpoints.login,
        data: request.toJson(),
      );

      final apiResponse = ApiResponse<LoginResponse>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
      );

      if (!apiResponse.success || apiResponse.data == null) {
        throw ApiException(apiResponse.message);
      }

      // Persist the token
      await TokenStorage.saveToken(apiResponse.data!.token);
      if (apiResponse.data!.refreshToken != null) {
        await TokenStorage.saveRefreshToken(apiResponse.data!.refreshToken!);
      }

      return apiResponse.data!;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiClient.handleError(e);
    }
  }

  /// POST /api/v1/auth/register
  ///
  /// Returns true on success. Does NOT auto-login.
  static Future<bool> register(RegisterRequest request) async {
    try {
      final response = await ApiClient.dio.post(
        ApiEndpoints.register,
        data: request.toJson(),
      );

      final apiResponse = ApiResponse<void>.fromJson(
        response.data as Map<String, dynamic>,
        null,
      );

      if (!apiResponse.success) {
        throw ApiException(apiResponse.message);
      }

      return true;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiClient.handleError(e);
    }
  }

  /// Clears stored tokens (local logout).
  static Future<void> logout() async {
    await TokenStorage.clearAll();
  }
}
