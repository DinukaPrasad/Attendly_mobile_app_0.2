import 'package:attendly/screens/student/attendance_history_screen.dart';
import 'package:attendly/screens/student/timetable_screen.dart';
import 'package:flutter/material.dart';
import '../../app/user_session.dart';
import '../../data/dummy_data.dart';
import 'student_home_screen.dart';
import '../../widgets/attendly_appBar.dart';

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({super.key});

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final firstName = UserSession.isLoggedIn
        ? UserSession.firstName
        : DummyData.currentStudent.fullName.split(' ').first;

    return Scaffold(
      appBar: AttendlyAppBar(UserName: firstName),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          StudentHomeScreen(),
          AttendanceHistoryScreen(),
          TimetableScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.history),
            icon: Icon(Icons.history_outlined),
            label: 'History',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.calendar_month),
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Timetable',
          ),
        ],
      ),
    );
  }
}
