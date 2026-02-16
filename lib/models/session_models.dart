// API-oriented session model with JSON serialization.

class ApiSession {
  final String id;
  final String moduleCode;
  final String moduleName;
  final String venue;
  final String lecturerName;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String status;
  final bool isOpen;
  final int totalStudents;
  final int checkedIn;

  const ApiSession({
    required this.id,
    required this.moduleCode,
    required this.moduleName,
    required this.venue,
    required this.lecturerName,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.status = 'upcoming',
    this.isOpen = false,
    this.totalStudents = 0,
    this.checkedIn = 0,
  });

  factory ApiSession.fromJson(Map<String, dynamic> json) {
    return ApiSession(
      id: json['id'] as String? ?? '',
      moduleCode: json['moduleCode'] as String? ?? '',
      moduleName: json['moduleName'] as String? ?? '',
      venue: json['venue'] as String? ?? '',
      lecturerName: json['lecturerName'] as String? ?? '',
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
      startTime: json['startTime'] as String? ?? '',
      endTime: json['endTime'] as String? ?? '',
      status: json['status'] as String? ?? 'upcoming',
      isOpen: json['isOpen'] as bool? ?? false,
      totalStudents: json['totalStudents'] as int? ?? 0,
      checkedIn: json['checkedIn'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'moduleCode': moduleCode,
    'moduleName': moduleName,
    'venue': venue,
    'lecturerName': lecturerName,
    'date': date.toIso8601String(),
    'startTime': startTime,
    'endTime': endTime,
    'status': status,
    'isOpen': isOpen,
    'totalStudents': totalStudents,
    'checkedIn': checkedIn,
  };
}
