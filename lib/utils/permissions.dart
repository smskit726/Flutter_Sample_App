import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_sample/utils/notification.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsUtil {
  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      // Permission.location, // 위치 정보
      Permission.storage // 저장 공간
    ].request();

    // notification
    await _requestNotificationPermission();
  }

  // notification 권한 요청
  Future<void> _requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;

    if (status != PermissionStatus.granted) {
      NotificationUtil notification = NotificationUtil();
      if (Platform.isIOS) {
        await notification.plugin
            .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
      } else if (Platform.isAndroid) {
        final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
            notification.plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

        await androidImplementation?.requestNotificationsPermission();
      }
    }
  }
}
