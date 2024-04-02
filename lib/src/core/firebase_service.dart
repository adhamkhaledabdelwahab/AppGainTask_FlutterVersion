import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:appgaintask/src/core/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage msg) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  log(
    'when app is Terminated ----  ${msg.notification}',
    name: "Firebase Notification Logging",
  );
  await NotificationService.getInstance.initialize();
  await NotificationService.getInstance.showNotification(
    id: math.Random().nextInt(10000),
    title: msg.notification?.title ?? "Empty Title",
    body: msg.notification?.body ?? "Empty Body",
  );
}

class FirebaseMessagingService {
  static Future initialize() async {
    final service = NotificationService.getInstance;
    await service.initialize();
    log('Firebase Messaging init');
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
    //onMessage
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log(
        'when app is open ----  ${message.notification!.body}',
        name: "Firebase Notification Logging",
      );
      service.showNotification(
        id: math.Random().nextInt(10000),
        title: message.notification?.title ?? "Empty Title",
        body: message.notification?.body ?? "Empty Body",
      );
    });

    //onResume
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log(
        'when app is open after tap----  $message',
        name: "Firebase Notification Logging",
      );
    });

    //onLaunch
    final RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      log('when app is open from terminated ----  $initialMessage',
          name: "Firebase Notification Logging");
    }
  }
}
