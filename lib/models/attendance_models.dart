// API-oriented attendance models with JSON serialization.

class MarkAttendanceRequest {
  final String sessionId;
  final String verificationMethod;
  final double? latitude;
  final double? longitude;

  const MarkAttendanceRequest({
    required this.sessionId,
    this.verificationMethod = 'biometric',
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() => {
    'sessionId': sessionId,
    'verificationMethod': verificationMethod,
    if (latitude != null) 'latitude': latitude,
    if (longitude != null) 'longitude': longitude,
  };
}

class ApiAttendance {
  final String id;
  final String sessionId;
  final String moduleCode;
  final String moduleName;
  final String studentName;
  final String studentNumber;
  final DateTime date;
  final String time;
  final String status;
  final String verificationMethod;

  const ApiAttendance({
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

  factory ApiAttendance.fromJson(Map<String, dynamic> json) {
    return ApiAttendance(
      id: json['id'] as String? ?? '',
      sessionId: json['sessionId'] as String? ?? '',
      moduleCode: json['moduleCode'] as String? ?? '',
      moduleName: json['moduleName'] as String? ?? '',
      studentName: json['studentName'] as String? ?? '',
      studentNumber: json['studentNumber'] as String? ?? '',
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
      time: json['time'] as String? ?? '',
      status: json['status'] as String? ?? 'present',
      verificationMethod: json['verificationMethod'] as String? ?? 'biometric',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'sessionId': sessionId,
    'moduleCode': moduleCode,
    'moduleName': moduleName,
    'studentName': studentName,
    'studentNumber': studentNumber,
    'date': date.toIso8601String(),
    'time': time,
    'status': status,
    'verificationMethod': verificationMethod,
  };
}
