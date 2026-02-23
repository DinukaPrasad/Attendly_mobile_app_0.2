import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';
import '../../widgets/status_chip.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Present', 'Absent', 'Late', 'Excused'];

  @override
  Widget build(BuildContext context) {
    final records = _selectedFilter == 'All'
        ? DummyData.attendanceRecords
        : DummyData.attendanceRecords
              .where(
                (r) => r.status.toLowerCase() == _selectedFilter.toLowerCase(),
              )
              .toList();

    return Scaffold(
      body: Column(
        children: [
          // Filter dropdown
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedFilter,
                  items: _filters
                      .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                      .toList(),
                  onChanged: (val) =>
                      setState(() => _selectedFilter = val ?? 'All'),
                ),
              ),
            ),
          ),

          // Summary row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _SummaryBadge(
                  label: 'Total',
                  count: DummyData.attendanceRecords.length,
                  color: Colors.blue,
                ),
                const SizedBox(width: 8),
                _SummaryBadge(
                  label: 'Present',
                  count: DummyData.attendanceRecords
                      .where((r) => r.status == 'present')
                      .length,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                _SummaryBadge(
                  label: 'Absent',
                  count: DummyData.attendanceRecords
                      .where((r) => r.status == 'absent')
                      .length,
                  color: Colors.red,
                ),
              ],
            ),
          ),

          // Records list
          Expanded(
            child: records.isEmpty
                ? Center(
                    child: Text(
                      'No records found',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      final record = records[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          onTap: () => _showDetails(context, record),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                record.moduleCode.substring(3),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            record.moduleName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Text(
                            '${record.date.day}/${record.date.month}/${record.date.year}  •  ${record.time}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          trailing: StatusChip(label: record.status),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showDetails(BuildContext context, dynamic record) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Attendance Details',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _DetailRow('Module', '${record.moduleCode} – ${record.moduleName}'),
            _DetailRow(
              'Date',
              '${record.date.day}/${record.date.month}/${record.date.year}',
            ),
            _DetailRow('Time Recorded', record.time),
            _DetailRow('Status', record.status.toString().toUpperCase()),
            _DetailRow('Verification', record.verificationMethod),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _SummaryBadge extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _SummaryBadge({
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
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 12, color: color)),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
