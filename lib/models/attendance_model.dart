class AttendanceModel {
  final String id;
  final String sessionId;
  final String moduleCode;
  final String moduleName;
  final String studentName;
  final String studentNumber;
  final DateTime date;
  final String time;
  final String status; // 'present', 'absent', 'late', 'excused'
  final String verificationMethod;

  const AttendanceModel({
    required this.id,
    required this.sessionId,
    required this.moduleCode,
    required this.moduleName,
    this.studentName = '',
    this.studentNumber = '',
    required this.date,
    required this.time,
    this.status = 'present',
    this.verificationMethod = 'biometric',
  });
}
