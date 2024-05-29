import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_sample/firebase_options.dart';
import 'package:flutter_sample/utils/notification.dart';

class FirebaseUtil {
  static final FirebaseUtil _instance = FirebaseUtil._internal();

  static final FirebaseMessaging messaging = FirebaseMessaging.instance;

  factory FirebaseUtil() {
    return _instance;
  }

  FirebaseUtil._internal();

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    _listenWhenAppIsInForeground();
    _listenWhenAppIsInBackground();
  }

  Future<String?> getToken() async {
    final token = FirebaseMessaging.instance.getToken();
    return token;
  }

  void _listenWhenAppIsInForeground() {
    FirebaseMessaging.onMessage.listen(NotificationUtil.show);
  }

  void _listenWhenAppIsInBackground() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    NotificationUtil.show(message);
  }
}
