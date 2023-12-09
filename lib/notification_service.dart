import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:system_settings/system_settings.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitialization =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    var iosInitialization = DarwinInitializationSettings();
    var initializationSetting = InitializationSettings(
      android: androidInitialization,
      iOS: iosInitialization,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveBackgroundNotificationResponse: (payload) {});
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User has given Permissions");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User has given provisional permissions");
    } else {
      // SystemSettings.appNotifications();
      AppSettings.openNotificationSettings();
      print("User Denied Permissions");
    }
  }

  Future<String> getDeviceToken() async {
    String? tokens = await messaging.getToken();
    return tokens!;
  }

  void isTokenRefresh() {
    messaging.onTokenRefresh.listen(
      (event) {
        event.toString();
      },
    );
  }

// for displaying notification when app is active
  void firebaseInit() {
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (kDebugMode) {
          print(message.notification!.title.toString());
          print(message.notification!.body.toString());
        }

        // showNotification(message);
      },
    );
  }
}
