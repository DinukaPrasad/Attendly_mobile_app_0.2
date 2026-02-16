import 'dart:io';
import 'package:dio/dio.dart';
import 'api_endpoints.dart';
import 'api_exception.dart';
import 'token_storage.dart';

/// Central HTTP client for the Attendly backend.
///
/// • Configures base URL, timeouts, and default headers.
/// • Attaches JWT via an interceptor on every request.
/// • Maps Dio errors to [ApiException] for consistent handling.
class ApiClient {
  ApiClient._();

  static final Dio _dio = _createDio();

  /// Public accessor so repositories can call `ApiClient.dio.get(...)` etc.
  static Dio get dio => _dio;

  // ── Dio factory ─────────────────────────────────────────────────

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      ),
    );

    // Auth interceptor — attaches Bearer token to every request.
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          // If 401, token may be invalid/expired — clear it.
          if (error.response?.statusCode == 401) {
            TokenStorage.clearToken();
          }
          handler.next(error);
        },
      ),
    );

    // Optional: logging in debug mode.
    // dio.interceptors.add(LogInterceptor(responseBody: true));

    return dio;
  }

  // ── Error helper ────────────────────────────────────────────────

  /// Converts any Dio/network error into a user-friendly [ApiException].
  static ApiException handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ApiException.timeout();

        case DioExceptionType.connectionError:
          return ApiException.network();

        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          String? serverMessage;
          if (data is Map<String, dynamic>) {
            serverMessage = data['message'] as String?;
          }
          return ApiException.fromStatusCode(statusCode, serverMessage);

        case DioExceptionType.cancel:
          return const ApiException('Request was cancelled.');

        default:
          return ApiException.unknown(error.message);
      }
    }

    if (error is SocketException) {
      return ApiException.network();
    }

    return ApiException.unknown(error.toString());
  }
}
