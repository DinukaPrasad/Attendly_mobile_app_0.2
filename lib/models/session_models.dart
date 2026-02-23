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
    final rawStatus = _asString(json['status']).toUpperCase();
    final startDateTime = _parseDateTime(json['startTime']);
    final endDateTime = _parseDateTime(json['endTime']);
    final sessionDate =
        _parseDateTime(json['date']) ?? startDateTime ?? DateTime.now();
    final isOpen =
        _asBool(json['isOpen']) ?? rawStatus == 'OPEN' || rawStatus == 'ACTIVE';

    return ApiSession(
      id: _asString(json['id']),
      moduleCode: _asString(json['moduleCode']),
      moduleName: _asString(json['moduleName']),
      venue: _asString(json['venue']).isNotEmpty
          ? _asString(json['venue'])
          : _asString(json['title']),
      lecturerName: _asString(json['lecturerName']),
      date: sessionDate,
      startTime: _displayTime(startDateTime, _asString(json['startTime'])),
      endTime: _displayTime(endDateTime, _asString(json['endTime'])),
      status: _normalizeStatus(rawStatus),
      isOpen: isOpen,
      totalStudents: _asInt(json['totalStudents']),
      checkedIn: _asInt(json['checkedIn']),
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

  static String _asString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString());
  }

  static bool? _asBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is num) return value != 0;
    final s = value.toString().toLowerCase();
    if (s == 'true' || s == '1') return true;
    if (s == 'false' || s == '0') return false;
    return null;
  }

  static int _asInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  static String _displayTime(DateTime? dt, String fallback) {
    if (dt == null) return fallback;
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static String _normalizeStatus(String status) {
    switch (status) {
      case 'OPEN':
      case 'ACTIVE':
        return 'active';
      case 'COMPLETED':
      case 'CLOSED':
        return 'completed';
      case 'CANCELLED':
        return 'cancelled';
      default:
        return 'upcoming';
    }
  }
}
