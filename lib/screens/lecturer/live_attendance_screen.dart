import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';
import '../../widgets/attendly_app_bar.dart';
import '../../widgets/status_chip.dart';

class LiveAttendanceScreen extends StatefulWidget {
  const LiveAttendanceScreen({super.key});

  @override
  State<LiveAttendanceScreen> createState() => _LiveAttendanceScreenState();
}

class _LiveAttendanceScreenState extends State<LiveAttendanceScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = DummyData.sessions.firstWhere(
      (s) => s.status == 'active',
      orElse: () => DummyData.sessions.first,
    );

    final attendanceList = DummyData.liveAttendanceList.where((student) {
      if (_searchQuery.isEmpty) return true;
      return student['name']!.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          student['number']!.contains(_searchQuery);
    }).toList();

    final presentCount = DummyData.liveAttendanceList
        .where((s) => s['status'] == 'present')
        .length;
    final lateCount = DummyData.liveAttendanceList
        .where((s) => s['status'] == 'late')
        .length;
    final absentCount = DummyData.liveAttendanceList
        .where((s) => s['status'] == 'absent')
        .length;

    return Scaffold(
      appBar: AttendlyAppBar(
        title: '${session.moduleCode} – Live',
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Export not implemented in prototype'),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary counters
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _CounterCard(
                  label: 'Present',
                  count: presentCount,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                _CounterCard(
                  label: 'Late',
                  count: lateCount,
                  color: Colors.orange,
                ),
                const SizedBox(width: 8),
                _CounterCard(
                  label: 'Absent',
                  count: absentCount,
                  color: Colors.red,
                ),
                const SizedBox(width: 8),
                _CounterCard(
                  label: 'Total',
                  count: DummyData.liveAttendanceList.length,
                  color: Colors.blue,
                ),
              ],
            ),
          ),

          // Search field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                hintText: 'Search by name or student number...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Student list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: attendanceList.length,
              itemBuilder: (context, index) {
                final student = attendanceList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getStatusColor(
                        student['status']!,
                      ).withValues(alpha: 0.15),
                      child: Text(
                        student['name']![0],
                        style: TextStyle(
                          color: _getStatusColor(student['status']!),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      student['name']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      student['number']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    trailing: StatusChip(label: student['status']!),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'present':
        return Colors.green;
      case 'late':
        return Colors.orange;
      case 'absent':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class _CounterCard extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _CounterCard({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              '$count',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: color,
              ),
            ),
            Text(label, style: TextStyle(fontSize: 11, color: color)),
          ],
        ),
      ),
    );
  }
}
