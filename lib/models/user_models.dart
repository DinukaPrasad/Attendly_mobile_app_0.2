// API-oriented user model with JSON serialization.
//
// This complements the existing [UserModel] (used by dummy data / UI).
// Repositories return this model from real API calls.

class ApiUser {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final String? studentNumber;
  final String? programme;
  final String? faculty;
  final String? avatarUrl;
  final bool isTrustedDevice;

  const ApiUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    this.studentNumber,
    this.programme,
    this.faculty,
    this.avatarUrl,
    this.isTrustedDevice = false,
  });

  factory ApiUser.fromJson(Map<String, dynamic> json) {
    final rawId = json['id'];
    return ApiUser(
      id: rawId?.toString() ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      role: json['role'] as String? ?? '',
      studentNumber: json['studentNumber'] as String?,
      programme: json['programme'] as String?,
      faculty: json['faculty'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      isTrustedDevice: json['isTrustedDevice'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'email': email,
    'role': role,
    'studentNumber': studentNumber,
    'programme': programme,
    'faculty': faculty,
    'avatarUrl': avatarUrl,
    'isTrustedDevice': isTrustedDevice,
  };
}
