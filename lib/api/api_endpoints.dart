/// Centralized API endpoint constants.
///
/// All paths are relative to [baseUrl]. The [ApiClient] prepends these
/// automatically, so callers just reference e.g. [ApiEndpoints.login].
class ApiEndpoints {
  ApiEndpoints._();

  // ── Base ────────────────────────────────────────────────────────
  static const String baseUrl = 'http://10.100.152.198:8080';
  static const String apiPrefix = '/api/v1';

  // ── Auth ────────────────────────────────────────────────────────
  static const String login = '$apiPrefix/auth/login';
  static const String register = '$apiPrefix/users';

  // ── Users ───────────────────────────────────────────────────────
  static const String usersMe = '$apiPrefix/users/me';

  // ── Sessions ────────────────────────────────────────────────────
  static const String sessions = '$apiPrefix/sessions';
  static String sessionById(String id) => '$apiPrefix/sessions/$id';
  static String sessionMe = '$apiPrefix/sessions/me';

  // ── Attendance ──────────────────────────────────────────────────
  static const String markAttendance = '$apiPrefix/attendance/mark';
  static const String myAttendance = '$apiPrefix/students/me/attendance';
}
