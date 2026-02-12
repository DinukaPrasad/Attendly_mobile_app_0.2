class SessionModel {
  final String id;
  final String moduleCode;
  final String moduleName;
  final String venue;
  final String lecturerName;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String status; // 'upcoming', 'active', 'completed', 'cancelled'
  final bool isOpen;
  final int totalStudents;
  final int checkedIn;

  const SessionModel({
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
}
