import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String label;

  const StatusChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getColor(label).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _getColor(label).withValues(alpha: 0.4)),
      ),
      child: Text(
        label[0].toUpperCase() + label.substring(1),
        style: TextStyle(
          color: _getColor(label),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
      case 'active':
      case 'completed':
        return const Color(0xFF388E3C);
      case 'absent':
      case 'cancelled':
        return const Color(0xFFD32F2F);
      case 'late':
        return const Color(0xFFF9A825);
      case 'excused':
        return const Color(0xFF1565C0);
      case 'upcoming':
        return const Color(0xFF7B1FA2);
      default:
        return Colors.grey;
    }
  }
}
