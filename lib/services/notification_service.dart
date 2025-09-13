import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool _hasExactAlarmPermission = false;

  bool get isInitialized => _isInitialized;
  bool get hasExactAlarmPermission => _hasExactAlarmPermission;

  Future<void> initialize() async {
    try {
      // Initialize timezone data
      tz.initializeTimeZones();

      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const InitializationSettings settings = InitializationSettings(
        android: androidSettings,
      );

      await _notifications.initialize(
        settings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      // Request notification permissions for Android 13+
      final androidImplementation =
          _notifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        // Request basic notification permission
        await androidImplementation.requestNotificationsPermission();

        // Request exact alarm permission (for Android 12+)
        try {
          _hasExactAlarmPermission =
              await androidImplementation.requestExactAlarmsPermission() ??
                  false;
        } catch (e) {
          if (kDebugMode) {
            print('Exact alarms permission request failed: $e');
          }
          _hasExactAlarmPermission = false;
        }
      }

      _isInitialized = true;

      if (kDebugMode) {
        print(
            'NotificationService initialized. Exact alarms: $_hasExactAlarmPermission');
      }
    } catch (e) {
      if (kDebugMode) {
        print('NotificationService initialization failed: $e');
      }
      _isInitialized = false;
    }
  }

  void _onNotificationTapped(NotificationResponse response) {
    if (kDebugMode) {
      print('Notification tapped: ${response.payload}');
    }
  }

  Future<void> showFavoriteNotification({
    required String universityName,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'favorites_channel',
      'Favorites',
      channelDescription: 'Notifications for university favorites',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      'University Favorited! ⭐',
      '$universityName has been added to your favorites',
      details,
      payload: universityName,
    );
  }

  Future<void> showUnfavoriteNotification({
    required String universityName,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'favorites_channel',
      'Favorites',
      channelDescription: 'Notifications for university favorites',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      'University Unfavorited 💔',
      '$universityName has been removed from your favorites',
      details,
      payload: universityName,
    );
  }

  Future<void> scheduleDeadlineReminder({
    required String universityName,
    required String deadlineType,
    required DateTime deadline,
    required int daysLeft,
  }) async {
    if (!_isInitialized) {
      if (kDebugMode) {
        print('Cannot schedule notification: service not initialized');
      }
      return;
    }

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'deadline_reminders',
      'Deadline Reminders',
      channelDescription: 'Notifications for university application deadlines',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    String title;
    String body;

    if (daysLeft == 7) {
      title = '📅 Deadline Reminder';
      body = '7 days left for $deadlineType at $universityName';
    } else if (daysLeft == 3) {
      title = '⚠️ Urgent Deadline';
      body = '3 days left for $deadlineType at $universityName';
    } else if (daysLeft == 1) {
      title = '🚨 Final Reminder';
      body = 'Tomorrow is the deadline for $deadlineType at $universityName';
    } else if (daysLeft == 0) {
      title = '🔔 Deadline Today';
      body = 'Today is the deadline for $deadlineType at $universityName';
    } else {
      title = '📅 Deadline Reminder';
      body = '$daysLeft days left for $deadlineType at $universityName';
    }

    final notificationId =
        '${universityName}_${deadlineType}_$daysLeft'.hashCode;

    try {
      await _notifications.show(
        notificationId,
        title,
        body,
        details,
        payload: '$universityName|$deadlineType|${deadline.toIso8601String()}',
      );

      if (kDebugMode) {
        print('Deadline reminder scheduled: $title');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to schedule deadline reminder: $e');
      }
    }
  }

  Future<void> showPastDeadlineNotification({
    required String universityName,
    required String deadlineType,
    required DateTime deadline,
  }) async {
    if (!_isInitialized) return;

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'past_deadlines',
      'Past Deadlines',
      channelDescription: 'Notifications for past university deadlines',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      icon: '@mipmap/ic_launcher',
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    final formattedDate = '${deadline.day}/${deadline.month}/${deadline.year}';

    try {
      await _notifications.show(
        DateTime.now().millisecondsSinceEpoch.remainder(100000),
        '📋 Past Deadline Info',
        '$deadlineType deadline for $universityName was on $formattedDate',
        details,
        payload: '$universityName|$deadlineType|${deadline.toIso8601String()}',
      );
    } catch (e) {
      if (kDebugMode) {
        print('Failed to show past deadline notification: $e');
      }
    }
  }

  Future<void> scheduleDailyDeadlineCheck() async {
    if (!_isInitialized || !_hasExactAlarmPermission) {
      if (kDebugMode) {
        print(
            'Cannot schedule daily check: ${!_isInitialized ? 'not initialized' : 'no exact alarm permission'}');
      }
      return;
    }

    try {
      // Schedule daily check at 9 AM
      final now = DateTime.now();
      var scheduledDate = DateTime(now.year, now.month, now.day, 9, 0);

      // If it's already past 9 AM today, schedule for tomorrow
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'daily_check',
        'Daily Deadline Check',
        channelDescription: 'Daily check for upcoming deadlines',
        importance: Importance.low,
        priority: Priority.low,
        playSound: false,
        enableVibration: false,
      );

      const NotificationDetails details = NotificationDetails(
        android: androidDetails,
      );

      await _notifications.zonedSchedule(
        999999, // Unique ID for daily check
        'Deadline Check',
        'Checking for upcoming deadlines...',
        tz.TZDateTime.from(scheduledDate, tz.local),
        details,
        payload: 'daily_check',
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time, // Repeat daily
      );

      if (kDebugMode) {
        print('Daily deadline check scheduled for ${scheduledDate.toString()}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to schedule daily deadline check: $e');
      }
      // Don't throw the error, just log it
    }
  }

  Future<void> cancelDeadlineNotification(
      String universityName, String deadlineType, int daysLeft) async {
    if (!_isInitialized) return;

    try {
      final notificationId =
          '${universityName}_${deadlineType}_$daysLeft'.hashCode;
      await _notifications.cancel(notificationId);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to cancel notification: $e');
      }
    }
  }

  Future<void> cancelAllDeadlineNotifications() async {
    if (!_isInitialized) return;

    try {
      await _notifications.cancelAll();
    } catch (e) {
      if (kDebugMode) {
        print('Failed to cancel all notifications: $e');
      }
    }
  }
}
