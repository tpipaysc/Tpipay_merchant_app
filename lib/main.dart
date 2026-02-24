import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lekra/firebase/get_Fcm_token.dart';
import 'package:lekra/firebase_options.dart';
import 'package:lekra/firebase_options_second.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/dashboard/service/all_service/dmt_service/create_beneficiary_account/create_beneficiary_account_screen.dart';
import 'package:lekra/views/screens/dashboard/service/all_service/dmt_service/dmt_dashboard_screen.dart/dmt_dashboard_screen.dart';
import 'package:lekra/views/screens/dashboard/service/all_service/dmt_service/dmt_enter_amount/dmt_enter_amount_screen.dart';
import 'package:lekra/views/screens/dashboard/service/all_service/dmt_service/dmt_mobile_no/dmt_mobile_no_enter_screen.dart';
import 'package:lekra/views/screens/dashboard/service/all_service/dmt_service/transaction_pin/transaction_pin_screen.dart';
import 'package:toastification/toastification.dart';
import 'services/init.dart';
import 'views/screens/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await Init().initialize();
  // await FCMService.initialize();

  // DEBUG: list apps before attempting init
  try {
    log('Firebase.apps before main init: ${Firebase.apps.map((a) => a.name).toList()}');
  } catch (_) {/* ignore if Firebase not ready */}

  // Safe initialize main Firebase with guard + catch
  try {
    if (Firebase.apps.isEmpty) {
      log('Initializing DEFAULT Firebase app (main) ...');
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      log('DEFAULT Firebase initialized.');
    } else {
      log('DEFAULT Firebase already initialized: ${Firebase.apps.map((a) => a.name).toList()}');
    }
  } on FirebaseException catch (e) {
    // ignore duplicate-app error, rethrow others
    if (e.code == 'duplicate-app' ||
        e.message?.contains('already exists') == true) {
      log('Ignored duplicate-app FirebaseException: ${e.message}');
    } else {
      rethrow;
    }
  } catch (e, s) {
    log('Unexpected error during Firebase init: $e\n$s');
    rethrow;
  }

  // services that depend on main firebase
  await Init().initialize();
  await FCMService.initialize();

  runApp(const MyApp());
}



final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> snackBarKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    log('Current state = $state');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: AppConstants.appName,
        navigatorKey: navigatorKey,
        themeMode: ThemeMode.light,
        theme: CustomTheme.light,
        debugShowCheckedModeBanner: false,
        home: const DmtDashboardScreen(),
        // home: const SplashScreen(),
        // home: const TransactionPinScreen(
        //   isEnterPin: true,
        // ),
      ),
    );
  }
}
