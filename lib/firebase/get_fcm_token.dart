import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/controllers/basic_controlller.dart';
import 'package:lekra/firebase_options.dart';
import 'package:lekra/services/voice_service.dart';

class FCMService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  static final basicController = Get.find<BasicController>();

  static Future<void> initialize() async {
    // 1. Request Firebase Permissions (Required for Android 13+ & iOS)
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted notification permissions');

      // 2. Initialize Local Notifications for Foreground Banners
      const androidInit =
          AndroidInitializationSettings('@mipmap/launcher_icon');
      const initSettings = InitializationSettings(android: androidInit);
      try {
        await _localNotifications.initialize(
          settings: initSettings,
          onDidReceiveNotificationResponse: (NotificationResponse response) {
            log("Notification tapped: ${response.payload}");
          },
        );
      } catch (e, s) {
        log('Local notifications init failed: $e\n$s');
      }

      // 3. Create a High Importance Channel (Forces banner to pop down)
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'tpipay_payment_channel', // id
        'Payment Notifications', // title
        description: 'Used for TpiPay Sound Box announcements',
        importance: Importance.max,
        playSound: true,
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      // 4. Get and log the Token
      // await getFCMToken();

      // 5. Listen for Messages while the App is OPEN (Foreground)
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log("Foreground Message: ${message.data}");

        // Show the visual banner
        _showLocalNotification(message, channel);

        // Trigger the Sound Box voice
        _handlePaymentLogic(message);
      });

      // 6. Set the Background/Terminated Handler
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    }
  }

  static Future<String?> getFCMToken() async {
    String? token = await _messaging.getToken();

    log("-----------------------------------------");
    log("FCM TOKEN: $token");
    log("-----------------------------------------");
    Get.find<AuthController>().saveFMCToken(token ?? "");

    return token ?? "";
  }

  static void _showLocalNotification(
      RemoteMessage message, AndroidNotificationChannel channel) {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      _localNotifications.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/launcher_icon',
          ),
        ),
      );
    }
  }

  static void _handlePaymentLogic(RemoteMessage message) {
    // IMPORTANT: In Firebase Console, put 'type' and 'amount' in 'Additional Options' -> 'Custom Data'
    if (message.data['type'] == 'payment_received' &&
        Get.find<BasicController>().isNotificationSound) {
      String amount = message.data['amount'] ?? "0";
      Future.delayed(const Duration(seconds: 2), () {
        VoiceService.speak("Received $amount rupees on TpiPay");
      });
    }
  }
}

// Global Background Handler (Must be outside the class)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Guard and pass options — background isolates need the options explicitly
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  log("Background Message: ${message.data}");

  if (message.data['type'] == 'payment_received' &&
      Get.find<BasicController>().isNotificationSound) {
    String amount = message.data['amount'] ?? "0";
    // Ensure VoiceService.speak is a static method
    Future.delayed(const Duration(seconds: 2), () async {
      await VoiceService.speak("Received $amount rupees on TpiPay");
    });
  }
}
