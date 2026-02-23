// API-oriented notification model with JSON serialization.

import 'package:flutter/material.dart';

class ApiNotification {
  final String id;
  final String title;
  final String message;
  final String type;
  final bool read;
  final DateTime createdAt;

  const ApiNotification({
    required this.id,
    required this.title,
    required this.message,
    this.type = 'GENERAL',
    this.read = false,
    required this.createdAt,
  });

  factory ApiNotification.fromJson(Map<String, dynamic> json) {
    return ApiNotification(
      id: _asString(json['id']),
      title: _asString(json['title']),
      message: _asString(json['message']),
      type: _asString(json['type']).toUpperCase(),
      read: _asBool(json['read']) ?? false,
      createdAt:
          DateTime.tryParse(_asString(json['createdAt'])) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'message': message,
    'type': type,
    'read': read,
    'createdAt': createdAt.toIso8601String(),
  };

  // ── UI helpers ────────────────────────────────────────────────

  /// Returns an appropriate icon based on the notification [type].
  IconData get icon {
    switch (type) {
      case 'ATTENDANCE_CONFIRMED':
        return Icons.check_circle;
      case 'SESSION_STARTING':
        return Icons.schedule;
      case 'LOW_ATTENDANCE':
        return Icons.warning_amber_rounded;
      case 'TIMETABLE_UPDATED':
        return Icons.event_note;
      case 'SESSION_CANCELLED':
        return Icons.cancel_outlined;
      case 'ANNOUNCEMENT':
        return Icons.campaign_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  /// Returns an appropriate color based on the notification [type].
  Color get iconColor {
    switch (type) {
      case 'ATTENDANCE_CONFIRMED':
        return const Color(0xFF388E3C); // success green
      case 'SESSION_STARTING':
        return const Color(0xFF1565C0); // primary blue
      case 'LOW_ATTENDANCE':
        return const Color(0xFFF9A825); // warning amber
      case 'TIMETABLE_UPDATED':
        return const Color(0xFF1565C0); // primary blue
      case 'SESSION_CANCELLED':
        return const Color(0xFFD32F2F); // error red
      case 'ANNOUNCEMENT':
        return const Color(0xFF7B1FA2); // purple
      default:
        return const Color(0xFF757575); // grey
    }
  }

  /// Returns a human-readable relative time string.
  String get timeAgo {
    final now = DateTime.now();
    final diff = now.difference(createdAt);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hr ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  // ── Private helpers ───────────────────────────────────────────

  static String _asString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  static bool? _asBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is num) return value != 0;
    final s = value.toString().toLowerCase();
    if (s == 'true' || s == '1') return true;
    if (s == 'false' || s == '0') return false;
    return null;
  }
}
