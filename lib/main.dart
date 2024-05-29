import 'package:flutter/material.dart';
import 'package:flutter_sample/base/config.dart';
import 'package:flutter_sample/screen/webview_screen.dart';
import 'package:flutter_sample/utils/firebase.dart';
import 'package:flutter_sample/utils/notification.dart';
import 'package:flutter_sample/utils/permissions.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  FirebaseUtil firebase = FirebaseUtil();
  await firebase.init();

  // Notification 초기화
  NotificationUtil notification = NotificationUtil();
  await notification.init();

  // 권한 요청
  PermissionsUtil permissionsUtil = PermissionsUtil();
  await permissionsUtil.requestPermissions();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _WebViewState();
}

class _WebViewState extends State<MyApp> {
  late final WebViewController controller;
  String url = "/";

  NotificationUtil notification = NotificationUtil();

  // 알림 클릭 이벤트 리스너 설정 (AOS)
  void _configureSelectNotificationSubject() {
    notification.selectNotificationSubject.listen((String? payload) async {
      if (payload != null) {
        setState(() {
          url = payload;
        });
      }
    });
  }

  // 알림 클릭 이벤트 리스너 설정 (IOS)
  // void _configureDidReceiveLocalNotificationSubject() {
  //   notification.didReceiveNotificationSubject.listen((event) async {
  //     if (event.payload != null) {
  //       setState(() {
  //         url = event.payload!;
  //       });
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _configureSelectNotificationSubject();
    // _configureDidReceiveLocalNotificationSubject();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {},
        onPageStarted: (url) {},
        onPageFinished: (String url) {},
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(Config.url));
  }

  @override
  void reassemble() {
    super.reassemble();
    controller.reload();
  }

  @override
  void dispose() {
    notification.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.title,
      // 테마 설정 (선택 사항)
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      //   useMaterial3: true,
      // ),
      home: WebviewScreen(controller),
    );
  }
}
