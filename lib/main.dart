import 'dart:async';
import 'dart:developer';

import 'package:appgaintask/src/core/app_router.dart';
import 'package:appgaintask/src/core/firebase_service.dart';
import 'package:appgaintask/src/core/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    await FirebaseMessagingService.initialize();
    await NotificationService.getInstance.initialize();
    final token = await FirebaseMessaging.instance.getToken();
    log("token: $token", name: "Firebase Token");
    runApp(const MyApp());
  }, (error, stack) {
    log(error.toString(), stackTrace: stack, name: "Global Error");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppGain Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
