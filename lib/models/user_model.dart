class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String role; // 'student' or 'lecturer'
  final String studentNumber;
  final String programme;
  final String faculty;
  final String avatarUrl;
  final bool isTrustedDevice;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    this.studentNumber = '',
    this.programme = '',
    this.faculty = '',
    this.avatarUrl = '',
    this.isTrustedDevice = false,
  });
}
