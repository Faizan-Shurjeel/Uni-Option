import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/university.dart';
import '../models/application_step.dart';
import 'notification_service.dart';

class DeadlineReminderService {
  static final DeadlineReminderService _instance =
      DeadlineReminderService._internal();
  factory DeadlineReminderService() => _instance;
  DeadlineReminderService._internal();

  final NotificationService _notificationService = NotificationService();
  final String _sentNotificationsKey = 'sent_deadline_notifications';
  final String _lastCheckKey = 'last_deadline_check';

  Set<String> _sentNotifications = {};
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    try {
      await _loadSentNotifications();

      // Try to schedule daily deadline check, but don't fail if it doesn't work
      try {
        await _notificationService.scheduleDailyDeadlineCheck();
      } catch (e) {
        if (kDebugMode) {
          print('Daily deadline check scheduling failed (this is OK): $e');
        }
      }

      _isInitialized = true;

      if (kDebugMode) {
        print('DeadlineReminderService initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('DeadlineReminderService initialization failed: $e');
      }
      _isInitialized = false;
    }
  }

  Future<void> _loadSentNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sentList = prefs.getStringList(_sentNotificationsKey) ?? [];
      _sentNotifications = Set<String>.from(sentList);
    } catch (e) {
      if (kDebugMode) {
        print('Error loading sent notifications: $e');
      }
      _sentNotifications = <String>{};
    }
  }

  Future<void> _saveSentNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
          _sentNotificationsKey, _sentNotifications.toList());
    } catch (e) {
      if (kDebugMode) {
        print('Error saving sent notifications: $e');
      }
    }
  }

  Future<void> checkAndSendDeadlineReminders(
      List<University> favoriteUniversities) async {
    if (!_isInitialized) {
      if (kDebugMode) {
        print(
            'DeadlineReminderService not initialized, skipping deadline check');
      }
      return;
    }

    final now = DateTime.now();

    for (final university in favoriteUniversities) {
      for (final step in university.applicationSteps) {
        if (step.deadline == null) continue;

        final deadline = step.deadline!;
        final daysLeft = deadline.difference(now).inDays;

        // Check if deadline is in the past (but within 10 days)
        if (daysLeft < 0 && daysLeft >= -10) {
          await _handlePastDeadline(university.name, step.title, deadline);
          continue;
        }

        // Check for upcoming deadlines (7 days before)
        if (daysLeft == 7) {
          await _handleUpcomingDeadline(
              university.name, step.title, deadline, daysLeft);
        }
      }
    }

    // Update last check time
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_lastCheckKey, now.toIso8601String());
    } catch (e) {
      if (kDebugMode) {
        print('Failed to update last check time: $e');
      }
    }
  }

  Future<void> _handleUpcomingDeadline(
    String universityName,
    String deadlineType,
    DateTime deadline,
    int daysLeft,
  ) async {
    final notificationKey =
        '${universityName}_${deadlineType}_${daysLeft}_${deadline.millisecondsSinceEpoch}';

    if (!_sentNotifications.contains(notificationKey)) {
      try {
        await _notificationService.scheduleDeadlineReminder(
          universityName: universityName,
          deadlineType: deadlineType,
          deadline: deadline,
          daysLeft: daysLeft,
        );

        _sentNotifications.add(notificationKey);
        await _saveSentNotifications();

        if (kDebugMode) {
          print('Sent deadline reminder: $notificationKey');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Failed to send deadline reminder: $e');
        }
      }
    }
  }

  Future<void> _handlePastDeadline(
    String universityName,
    String deadlineType,
    DateTime deadline,
  ) async {
    final notificationKey =
        'past_${universityName}_${deadlineType}_${deadline.millisecondsSinceEpoch}';

    if (!_sentNotifications.contains(notificationKey)) {
      try {
        await _notificationService.showPastDeadlineNotification(
          universityName: universityName,
          deadlineType: deadlineType,
          deadline: deadline,
        );

        _sentNotifications.add(notificationKey);
        await _saveSentNotifications();

        if (kDebugMode) {
          print('Sent past deadline notification: $notificationKey');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Failed to send past deadline notification: $e');
        }
      }
    }
  }

  List<Map<String, dynamic>> getUpcomingDeadlines(
      List<University> favoriteUniversities) {
    final now = DateTime.now();
    List<Map<String, dynamic>> deadlines = [];

    for (final university in favoriteUniversities) {
      for (final step in university.applicationSteps) {
        if (step.deadline == null) continue;

        final daysLeft = step.deadline!.difference(now).inDays;

        // Include upcoming deadlines (next 30 days) and recent past deadlines (last 10 days)
        if (daysLeft >= -10 && daysLeft <= 30) {
          deadlines.add({
            'university': university,
            'step': step,
            'daysLeft': daysLeft,
            'isPast': daysLeft < 0,
          });
        }
      }
    }

    // Sort by deadline (past deadlines first, then upcoming)
    deadlines.sort((a, b) {
      final aDeadline = (a['step'] as ApplicationStep).deadline!;
      final bDeadline = (b['step'] as ApplicationStep).deadline!;
      return aDeadline.compareTo(bDeadline);
    });

    return deadlines;
  }

  Future<void> cleanupOldNotifications() async {
    // Remove notifications for deadlines that are more than 30 days old
    final cutoffDate = DateTime.now().subtract(const Duration(days: 30));
    final toRemove = <String>{};

    for (final notification in _sentNotifications) {
      // Extract timestamp from notification key if possible
      final parts = notification.split('_');
      if (parts.length >= 2) {
        try {
          final timestamp = int.tryParse(parts.last);
          if (timestamp != null) {
            final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
            if (date.isBefore(cutoffDate)) {
              toRemove.add(notification);
            }
          }
        } catch (e) {
          // Keep notification if parsing fails
          continue;
        }
      }
    }

    _sentNotifications.removeAll(toRemove);
    await _saveSentNotifications();

    if (kDebugMode) {
      print('Cleaned up ${toRemove.length} old notifications');
    }
  }

  Future<DateTime?> getLastCheckTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastCheckString = prefs.getString(_lastCheckKey);
      if (lastCheckString != null) {
        return DateTime.parse(lastCheckString);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting last check time: $e');
      }
    }
    return null;
  }
}
