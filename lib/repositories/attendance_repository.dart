import '../api/api_client.dart';
import '../api/api_endpoints.dart';
import '../api/api_exception.dart';
import '../api/api_response.dart';
import '../models/attendance_models.dart';

/// Handles attendance-related API calls.
class AttendanceRepository {
  AttendanceRepository._();

  /// POST /api/v1/attendance/mark
  ///
  /// Marks attendance for the current student in a given session.
  static Future<ApiAttendance> markAttendance(
    MarkAttendanceRequest request,
  ) async {
    try {
      final response = await ApiClient.dio.post(
        ApiEndpoints.markAttendance,
        data: request.toJson(),
      );

      final apiResponse = ApiResponse<ApiAttendance>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => ApiAttendance.fromJson(json as Map<String, dynamic>),
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

  /// GET /api/v1/students/me/attendance
  ///
  /// Returns the logged-in student's attendance history.
  static Future<List<ApiAttendance>> fetchMyAttendance() async {
    try {
      final response = await ApiClient.dio.get(ApiEndpoints.myAttendance);

      final apiResponse = ApiResponse<List<ApiAttendance>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => (json as List)
            .map((e) => ApiAttendance.fromJson(e as Map<String, dynamic>))
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
