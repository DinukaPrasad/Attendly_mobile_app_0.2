/// Generic API response wrapper.
///
/// The backend returns every response in this shape:
/// ```json
/// { "success": true/false, "message": "...", "data": ... }
/// ```
class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;

  const ApiResponse({required this.success, required this.message, this.data});

  /// Builds an [ApiResponse] from raw JSON, using [fromJsonT] to
  /// deserialize the `data` field into the desired type [T].
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : null,
    );
  }
}
