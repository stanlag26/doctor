import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:doctor/ui/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'entity/course_hive.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CourseHiveAdapter());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.Max,
        channelShowBadge: true, channelDescription: 'basic_channel',
        locked: true,
        enableLights: true,
        enableVibration: true,
        onlyAlertOnce: false,
        criticalAlerts: true,
      ),
    ],
  );

  runApp(const MyApp());
}

