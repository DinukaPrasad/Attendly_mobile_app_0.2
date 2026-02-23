import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/role_select_screen.dart';
import '../screens/student/student_dashboard_screen.dart';
import '../screens/student/timetable_screen.dart';
import '../screens/student/session_details_screen.dart';
import '../screens/student/checkin_wizard_screen.dart';
import '../screens/student/attendance_history_screen.dart';
import '../screens/lecturer/lecturer_dashboard_screen.dart';
import '../screens/lecturer/live_attendance_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/notifications/notifications_screen.dart';

/// Route name constants for easy reference
class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String roleSelect = '/role-select';

  // Student routes
  static const String studentHome = '/student-home';
  static const String studentDashboard = '/student-dashboard';
  static const String studentTimetable = '/student-timetable';
  static const String sessionDetails = '/session-details';
  static const String checkinWizard = '/checkin-wizard';
  static const String attendanceHistory = '/attendance-history';

  // Lecturer routes
  static const String lecturerHome = '/lecturer-home';
  static const String lecturerDashboard = '/lecturer-dashboard';
  static const String liveAttendance = '/live-attendance';

  // Shared routes
  static const String profile = '/profile';
  static const String notifications = '/notifications';

  /// Route map used by MaterialApp
  ///
  /// FUTURE: Role-based route guards will be added here.
  /// Guards will check user role from the auth state and
  /// redirect unauthorized users back to login or an error page.
  /// Example: A student trying to access '/lecturer-home' would
  /// be redirected to '/student-home'.
  static Map<String, WidgetBuilder> get routes => {
    splash: (_) => const SplashScreen(),
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    roleSelect: (_) => const RoleSelectScreen(),
    studentHome: (_) => const StudentDashboardScreen(),
    studentDashboard: (_) => const StudentDashboardScreen(),
    studentTimetable: (_) => const TimetableScreen(),
    sessionDetails: (_) => const SessionDetailsScreen(),
    checkinWizard: (_) => const CheckinWizardScreen(),
    attendanceHistory: (_) => const AttendanceHistoryScreen(),
    lecturerHome: (_) => const LecturerDashboardScreen(),
    lecturerDashboard: (_) => const LecturerDashboardScreen(),
    liveAttendance: (_) => const LiveAttendanceScreen(),
    profile: (_) => const ProfileScreen(),
    notifications: (_) => const NotificationsScreen(),
  };
}
