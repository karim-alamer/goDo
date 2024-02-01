import 'package:flutter/material.dart';
import 'package:go_do/my_app.dart';
import 'package:go_do/services/notify_service.dart';
import 'package:timezone/data/latest.dart' as tzdata;

void main() {
  tzdata.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
 
  final NotifyHelperService notifyHelper = NotifyHelperService();
  notifyHelper.setup();

  runApp(
    const MyApp(),
  );
}

