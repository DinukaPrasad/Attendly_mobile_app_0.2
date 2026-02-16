/// Custom exception for API errors with clear, user-friendly messages.
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException($statusCode): $message';

  // ── Factory helpers for common HTTP errors ──────────────────────

  factory ApiException.fromStatusCode(
    int? statusCode, [
    String? serverMessage,
  ]) {
    switch (statusCode) {
      case 400:
        return ApiException(
          serverMessage ?? 'Bad request. Please check your input.',
          statusCode: 400,
        );
      case 401:
        return ApiException(
          serverMessage ?? 'Session expired. Please log in again.',
          statusCode: 401,
        );
      case 403:
        return ApiException(
          serverMessage ?? 'You do not have permission to perform this action.',
          statusCode: 403,
        );
      case 404:
        return ApiException(
          serverMessage ?? 'The requested resource was not found.',
          statusCode: 404,
        );
      case 409:
        return ApiException(
          serverMessage ?? 'Conflict — the resource already exists.',
          statusCode: 409,
        );
      case 422:
        return ApiException(
          serverMessage ?? 'Validation failed. Please check your input.',
          statusCode: 422,
        );
      case 500:
        return ApiException(
          serverMessage ?? 'Server error. Please try again later.',
          statusCode: 500,
        );
      default:
        return ApiException(
          serverMessage ?? 'Something went wrong (code $statusCode).',
          statusCode: statusCode,
        );
    }
  }

  factory ApiException.network() =>
      const ApiException('No internet connection. Please check your network.');

  factory ApiException.timeout() =>
      const ApiException('Request timed out. Please try again.');

  factory ApiException.unknown([String? detail]) =>
      ApiException(detail ?? 'An unexpected error occurred.');
}
