import 'package:flutter/material.dart';

class AttendlyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String UserName;

  const AttendlyAppBar({super.key, required this.UserName});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(Icons.play_circle_filled_outlined),
      title: Text(_getGreeting() + " " + UserName),
      actions: [
        _notificationsIcon(context),
        _profileIcon(context),
        const SizedBox(width: 8),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning,';
    } else if (hour < 18) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }

  Widget _notificationsIcon(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notifications_outlined),
      onPressed: () {
        Navigator.pushNamed(context, '/notifications');
      },
    );
  }

  Widget _profileIcon(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.person_outline),
      onPressed: () {
        Navigator.pushNamed(context, '/profile');
      },
    );
  }
}
