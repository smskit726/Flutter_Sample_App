import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class NotificationUtil {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final BehaviorSubject<ReceiveNotification> _didReceiveLocalNotificationSubject =
      BehaviorSubject<ReceiveNotification>();

  final BehaviorSubject<String?> _selectNotificationSubject = BehaviorSubject<String?>();

  static final NotificationUtil _instance = NotificationUtil._internal();

  factory NotificationUtil() {
    return _instance;
  }

  NotificationUtil._internal();

  Future<void> init() async {
    // Android 초기화 설정
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');

    // iOS 초기화 설정
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
        _didReceiveLocalNotificationSubject
            .add(ReceiveNotification(id: id, title: title, body: body, payload: payload));
      },
    );

    // 플랫폼 초기화 설정
    InitializationSettings settings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin);

    // 백그라운드 알림 처리
    await _onBackgroundNotificationResponse();

    // 로컬 알림 초기화
    await _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        _selectNotificationSubject.add(details.payload);
      },
    );
  }

  // 백그라운드 알림 클릭 handler
  Future<void> _onBackgroundNotificationResponse() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails != null && notificationAppLaunchDetails.didNotificationLaunchApp) {
      String? payload = notificationAppLaunchDetails.notificationResponse?.payload;
      _selectNotificationSubject.add(payload);
    }
  }

  // 알림 표시
  static Future<void> show(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      await _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel', // 채널 ID
            'high_importance_notification', // 채널 이름
            importance: Importance.max,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  void onDispose() {
    _didReceiveLocalNotificationSubject.close();
    _selectNotificationSubject.close();
  }

  // 플러그인 인스턴스 반환
  FlutterLocalNotificationsPlugin get plugin => _flutterLocalNotificationsPlugin;

  // 알림 수신 스트림 반환
  BehaviorSubject<ReceiveNotification> get didReceiveNotificationSubject => _didReceiveLocalNotificationSubject;

  // 알림 선택 스트림 반환
  BehaviorSubject<String?> get selectNotificationSubject => _selectNotificationSubject;
}

class ReceiveNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  ReceiveNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}
