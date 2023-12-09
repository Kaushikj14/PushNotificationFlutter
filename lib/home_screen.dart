import 'package:flutter/material.dart';
import 'package:flutter_application_3/notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();

    // Active app notify
    notificationServices.firebaseInit();

    // For Checking is token is expired or not
    notificationServices.isTokenRefresh();
    // For getting Tokens
    notificationServices.getDeviceToken().then(
      (value) {
        print("DEVICE TOKEN");
        print(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
