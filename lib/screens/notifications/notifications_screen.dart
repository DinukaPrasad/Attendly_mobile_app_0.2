import 'package:flutter/material.dart';
import '../../widgets/attendly_app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy notification data (UI only — no API)
    final notifications = [
      _NotificationItem(
        icon: Icons.check_circle,
        iconColor: const Color(0xFF388E3C),
        title: 'Attendance Confirmed',
        subtitle: 'Your check-in for CS201 has been recorded successfully.',
        time: '5 min ago',
      ),
      _NotificationItem(
        icon: Icons.schedule,
        iconColor: const Color(0xFF1565C0),
        title: 'Session Starting Soon',
        subtitle: 'IS304 — Software Engineering starts in 15 minutes.',
        time: '12 min ago',
      ),
      _NotificationItem(
        icon: Icons.warning_amber_rounded,
        iconColor: const Color(0xFFF9A825),
        title: 'Low Attendance Warning',
        subtitle:
            'Your attendance for MA102 is below 75%. Please attend upcoming sessions.',
        time: '1 hr ago',
      ),
      _NotificationItem(
        icon: Icons.event_note,
        iconColor: const Color(0xFF1565C0),
        title: 'Timetable Updated',
        subtitle: 'CS201 lecture on Friday has been moved to Room B-12.',
        time: '3 hrs ago',
      ),
      _NotificationItem(
        icon: Icons.cancel_outlined,
        iconColor: const Color(0xFFD32F2F),
        title: 'Session Cancelled',
        subtitle: 'IS310 — Database Systems session for tomorrow is cancelled.',
        time: 'Yesterday',
      ),
    ];

    return Scaffold(
      appBar: const AttendlyAppBar(title: 'Notifications'),
      body: notifications.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.notifications_off_outlined,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No notifications',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'You\'re all caught up! New notifications will appear here.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: notifications.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, indent: 72, color: Colors.grey.shade200),
              itemBuilder: (context, index) {
                final item = notifications[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: item.iconColor.withValues(alpha: 0.12),
                    child: Icon(item.icon, color: item.iconColor, size: 22),
                  ),
                  title: Text(
                    item.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.time,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade400,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                );
              },
            ),
    );
  }
}

/// Simple data class for dummy notification items.
class _NotificationItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String time;

  _NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
  });
}
