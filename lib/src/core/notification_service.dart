import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static NotificationService? _instance;

  NotificationService._();

  static NotificationService get getInstance {
    _instance ??= NotificationService._();
    return _instance!;
  }

  final _notificationService = FlutterLocalNotificationsPlugin();

  final _channel = const AndroidNotificationChannel(
    "Appgain_Channel_Id",
    "Appgain_Channel_Name",
    description: "Appgain_Channel_Description",
    importance: Importance.max,
    playSound: true,
  );

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _notificationService
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    await _notificationService.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse nr) {
        // TODO
        log(nr.toString(), name: 'Local Notification Logging');
      },
    );
  }

  Future<NotificationDetails> notificationDetails() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: _channel.importance,
      priority: Priority.max,
      playSound: _channel.playSound,
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails();

    return NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await notificationDetails();
    await _notificationService.show(id, title, body, details);
  }

  Future<void> cancelNotification() async {
    await _notificationService.cancelAll();
  }

  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) {
    // TODO
    log(
      "title: $title, body: $body, payload: $payload",
      name: 'Local Notification Logging',
    );
  }
}
