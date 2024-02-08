import 'dart:async';
import 'package:digital_sobol_test/src/features/app_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void run() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(const AppView());
  }, (error, stack) async {
    debugPrint('ERROR');
    debugPrint('$error');
    debugPrint('$stack');
    debugPrint('END ERROR');
  });
}
