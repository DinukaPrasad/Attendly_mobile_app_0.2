import 'package:attendly/widgets/attendly_appBar.dart';
import 'package:flutter/material.dart';
import '../../app/user_session.dart';
import '../../data/dummy_data.dart';
import '../../widgets/status_chip.dart';

class LecturerDashboardScreen extends StatefulWidget {
  const LecturerDashboardScreen({super.key});

  @override
  State<LecturerDashboardScreen> createState() =>
      _LecturerDashboardScreenState();
}

class _LecturerDashboardScreenState extends State<LecturerDashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarAccent = theme.colorScheme.secondary;
    final displayName = UserSession.isLoggedIn
        ? UserSession.fullName
        : DummyData.currentLecturer.fullName;
    final firstName = UserSession.isLoggedIn
        ? UserSession.firstName
        : DummyData.currentLecturer.fullName.split(' ').first;

    return Scaffold(
      appBar: AttendlyAppBar(UserName: firstName),
      body: IndexedStack(
        index: _currentIndex,
        children: const [_HomeTab(), _SessionsTab()],
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
            selectedIcon: Icon(Icons.dashboard),
            icon: Icon(Icons.dashboard_outlined),
            label: 'Sessions',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HOME TAB - Today's Sessions Overview
// ─────────────────────────────────────────────────────────────────────────────

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final todaySessions = DummyData.sessions.where((s) {
      return s.date.year == now.year &&
          s.date.month == now.month &&
          s.date.day == now.day;
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick stats
          Row(
            children: [
              _StatCard(
                label: "Today's Sessions",
                value: '${todaySessions.length}',
                icon: Icons.calendar_today,
                color: Colors.blue,
              ),
              const SizedBox(width: 12),
              _StatCard(
                label: 'Active Now',
                value:
                    '${todaySessions.where((s) => s.status == 'active').length}',
                icon: Icons.play_circle_outline,
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 24),

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
              TextButton(onPressed: () {}, child: const Text('View All')),
            ],
          ),
          const SizedBox(height: 8),

          if (todaySessions.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
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
            )
          else
            ...todaySessions.map(
              (session) => _TodaySessionCard(session: session),
            ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodaySessionCard extends StatelessWidget {
  final dynamic session;

  const _TodaySessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/live-attendance'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          session.moduleCode,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      StatusChip(label: session.status),
                    ],
                  ),
                  Text(
                    '${session.checkedIn}/${session.totalStudents}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                session.moduleName,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${session.startTime} – ${session.endTime} • ${session.venue}',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              if (session.status == 'active') ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/live-attendance'),
                    icon: const Icon(Icons.visibility, size: 18),
                    label: const Text('View Live'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SESSIONS TAB - All Sessions Management
// ─────────────────────────────────────────────────────────────────────────────

class _SessionsTab extends StatefulWidget {
  const _SessionsTab();

  @override
  State<_SessionsTab> createState() => _SessionsTabState();
}

class _SessionsTabState extends State<_SessionsTab> {
  String _selectedModule = 'All';
  final List<String> _modules = ['All', 'COS301', 'COS326', 'COS341'];

  @override
  Widget build(BuildContext context) {
    final sessions = _selectedModule == 'All'
        ? DummyData.sessions
        : DummyData.sessions
              .where((s) => s.moduleCode == _selectedModule)
              .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Module dropdown
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectedModule,
                items: _modules
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (val) =>
                    setState(() => _selectedModule = val ?? 'All'),
              ),
            ),
          ),
        ),

        // Sessions header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Sessions (${sessions.length})',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),

        // Session list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  session.moduleCode,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              StatusChip(label: session.status),
                            ],
                          ),
                          Text(
                            '${session.checkedIn}/${session.totalStudents}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        session.moduleName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${session.date.day}/${session.date.month} • ${session.startTime} – ${session.endTime} • ${session.venue}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      session.isOpen
                                          ? 'Session closed (UI only)'
                                          : 'Session opened (UI only)',
                                    ),
                                  ),
                                );
                              },
                              child: Text(session.isOpen ? 'Close' : 'Open'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/live-attendance',
                                );
                              },
                              child: const Text('View Live'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
