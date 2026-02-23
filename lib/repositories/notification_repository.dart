import '../api/api_client.dart';
import '../api/api_endpoints.dart';
import '../api/api_exception.dart';
import '../api/api_response.dart';
import '../models/notification_models.dart';

/// Handles notification-related API calls.
class NotificationRepository {
  NotificationRepository._();

  /// GET /api/v1/notifications/me
  ///
  /// Returns all notifications for the authenticated user.
  static Future<List<ApiNotification>> fetchMyNotifications() async {
    try {
      final response = await ApiClient.dio.get(ApiEndpoints.notifications);

      final apiResponse = ApiResponse<List<ApiNotification>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => (json as List)
            .map((e) => ApiNotification.fromJson(e as Map<String, dynamic>))
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
}
