import '../api/api_client.dart';
import '../api/api_endpoints.dart';
import '../api/api_exception.dart';
import '../api/api_response.dart';
import '../models/user_models.dart';

/// Handles user-related API calls.
class UserRepository {
  UserRepository._();

  /// GET /api/v1/users/me
  ///
  /// Returns the currently authenticated user's profile.
  static Future<ApiUser> fetchCurrentUser() async {
    try {
      final response = await ApiClient.dio.get(ApiEndpoints.usersMe);

      final apiResponse = ApiResponse<ApiUser>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => ApiUser.fromJson(json as Map<String, dynamic>),
      );

      if (!apiResponse.success || apiResponse.data == null) {
        throw ApiException(apiResponse.message);
      }

      return apiResponse.data!;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiClient.handleError(e);
    }
  }
}
