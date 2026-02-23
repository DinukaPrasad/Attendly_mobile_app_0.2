import 'package:attendly/models/session_models.dart';
import 'package:attendly/repositories/session_repository.dart';
import 'package:attendly/widgets/attendly_card.dart';
import 'package:attendly/widgets/status_chip.dart';
import 'package:flutter/material.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  late Future<List<ApiSession>> _todaySessionsFuture;

  @override
  void initState() {
    super.initState();
    _todaySessionsFuture = _fetchTodaySessions();
  }

  Future<List<ApiSession>> _fetchTodaySessions() async {
    final sessions = await SessionRepository.fetchMySessions();
    final now = DateTime.now().toLocal();
    return sessions.where((s) {
      final d = s.date.toLocal();
      return d.year == now.year && d.month == now.month && d.day == now.day;
    }).toList();
  }

  void _retry() {
    setState(() {
      _todaySessionsFuture = _fetchTodaySessions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Today's sessions header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Sessions",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  // Handled via bottom nav
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Session cards
          FutureBuilder<List<ApiSession>>(
            future: _todaySessionsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasError) {
                return AttendlyCard(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red.shade300,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Failed to load sessions',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton.icon(
                            onPressed: _retry,
                            icon: const Icon(Icons.refresh, size: 18),
                            label: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              final todaySessions = snapshot.data ?? [];

              if (todaySessions.isEmpty) {
                return AttendlyCard(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Icon(
                            Icons.event_available,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No sessions scheduled for today',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return Column(
                children: todaySessions
                    .map((session) => _SessionCard(session: session))
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  final ApiSession session;

  const _SessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    return AttendlyCard(
      onTap: () {
        Navigator.pushNamed(context, '/session-details');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                session.moduleCode,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              StatusChip(label: session.status),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            session.moduleName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(
                '${session.startTime} – ${session.endTime}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  session.venue,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (session.status == 'active') ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/session-details');
                },
                icon: const Icon(Icons.check_circle_outline, size: 18),
                label: const Text('Check In'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
