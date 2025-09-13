import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
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
}
