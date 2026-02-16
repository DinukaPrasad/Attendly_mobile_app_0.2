import '../api/api_client.dart';
import '../api/api_endpoints.dart';
import '../api/api_exception.dart';
import '../api/api_response.dart';
import '../models/session_models.dart';

/// Handles session-related API calls.
class SessionRepository {
  SessionRepository._();

  /// GET /api/v1/sessions
  ///
  /// Returns all sessions visible to the authenticated user.
  static Future<List<ApiSession>> fetchSessions() async {
    try {
      final response = await ApiClient.dio.get(ApiEndpoints.sessions);

      final apiResponse = ApiResponse<List<ApiSession>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => (json as List)
            .map((e) => ApiSession.fromJson(e as Map<String, dynamic>))
            .toList(),
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

  /// GET /api/v1/sessions/:id
  ///
  /// Returns a single session by its ID.
  static Future<ApiSession> fetchSessionById(String id) async {
    try {
      final response = await ApiClient.dio.get(ApiEndpoints.sessionById(id));

      final apiResponse = ApiResponse<ApiSession>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => ApiSession.fromJson(json as Map<String, dynamic>),
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
