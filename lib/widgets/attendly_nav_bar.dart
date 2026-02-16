import 'package:flutter/material.dart';

/// Navigation item descriptor used by [AttendlyNavBar].
class NavBarItem {
  final IconData icon;
  final String label;

  const NavBarItem({required this.icon, required this.label});
}

/// Reusable bottom navigation bar for Attendly.
///
/// Wraps [BottomNavigationBar] with consistent theming and a
/// clean callback API.  Screens supply their own [items] list
/// and handle index changes via [onTap].
///
/// Usage:
/// ```dart
/// AttendlyNavBar(
///   currentIndex: _currentIndex,
///   onTap: (i) => setState(() => _currentIndex = i),
///   items: const [
///     NavBarItem(icon: Icons.home, label: 'Home'),
///     NavBarItem(icon: Icons.calendar_today, label: 'Timetable'),
///   ],
/// )
/// ```
class AttendlyNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavBarItem> items;

  const AttendlyNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: items
          .map(
            (item) => BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.label,
            ),
          )
          .toList(),
    );
  }
}
