import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';
import '../../widgets/attendly_button.dart';
import '../../app/theme.dart';

class SessionDetailsScreen extends StatelessWidget {
  const SessionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use first active session as demo
    final session = DummyData.sessions.firstWhere(
      (s) => s.status == 'active',
      orElse: () => DummyData.sessions.first,
    );

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Session info card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AttendlyTheme.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            session.moduleCode,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            session.moduleName,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _InfoRow(
                      icon: Icons.person_outline,
                      label: 'Lecturer',
                      value: session.lecturerName,
                    ),
                    const SizedBox(height: 10),
                    _InfoRow(
                      icon: Icons.access_time,
                      label: 'Time',
                      value: '${session.startTime} – ${session.endTime}',
                    ),
                    const SizedBox(height: 10),
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'Venue',
                      value: session.venue,
                    ),
                    const SizedBox(height: 10),
                    _InfoRow(
                      icon: Icons.calendar_today,
                      label: 'Date',
                      value:
                          '${session.date.day}/${session.date.month}/${session.date.year}',
                    ),
                    const SizedBox(height: 10),
                    _InfoRow(
                      icon: Icons.people_outline,
                      label: 'Attendance',
                      value: '${session.checkedIn}/${session.totalStudents}',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Eligibility checks
            Text(
              'Eligibility Checks',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _EligibilityCheck(
              icon: Icons.access_time,
              title: 'Time Window',
              subtitle: 'Session is currently active',
              status: true,
            ),
            _EligibilityCheck(
              icon: Icons.location_on,
              title: 'Location',
              subtitle: 'Within campus geofence',
              status: true,
            ),
            _EligibilityCheck(
              icon: Icons.wifi,
              title: 'WiFi Network',
              subtitle: 'Connected to university WiFi',
              status: true,
            ),
            _EligibilityCheck(
              icon: Icons.devices,
              title: 'Trusted Device',
              subtitle: 'Device registered & verified',
              status: true,
            ),
            _EligibilityCheck(
              icon: Icons.face,
              title: 'Biometric Ready',
              subtitle: 'Face verification available',
              status: false,
            ),
            const SizedBox(height: 32),

            // Check-in button
            SizedBox(
              width: double.infinity,
              child: AttendlyButton(
                label: 'Start Check-in',
                icon: Icons.check_circle,
                onPressed: () {
                  Navigator.pushNamed(context, '/checkin-wizard');
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class _EligibilityCheck extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool status;

  const _EligibilityCheck({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: (status ? AttendlyTheme.successColor : Colors.orange)
                .withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: status ? AttendlyTheme.successColor : Colors.orange,
            size: 20,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: Icon(
          status ? Icons.check_circle : Icons.warning_amber_rounded,
          color: status ? AttendlyTheme.successColor : Colors.orange,
        ),
      ),
    );
  }
}
