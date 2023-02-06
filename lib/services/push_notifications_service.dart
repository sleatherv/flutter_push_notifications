import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static StreamController<String> _messageSream =
      StreamController.broadcast(); //this is a controller

  static Stream<String> get messageStream => _messageSream.stream;

  static Future _onBackgroundHandler(RemoteMessage message) async {
    // print("On Background handler ${message.messageId}");
    _messageSream.add(message.notification?.title ?? "No Title");
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    // print("On message handler ${message.messageId}");
    _messageSream.add(message.notification?.title ?? "No Title");
  }

  static Future _onMessageOpenHandler(RemoteMessage message) async {
    // print("On message open handler ${message.messageId}");
    _messageSream.add(message.notification?.title ?? "No Title");
  }

  static Future initializeApp() async {
    // push notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    // print(token);

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenHandler);
    //Local notifications
  }

  static closeStreams() {
    _messageSream.close();
  }
}
