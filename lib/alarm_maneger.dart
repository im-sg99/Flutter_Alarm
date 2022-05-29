import 'dart:isolate';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm/home_page.dart';

void printHello() {
final DateTime now = DateTime.now();
final int isolateId = Isolate.current.hashCode;
print("[$now] Hello, world! isolate=$isolateId function='$printHello'");
}

main() async {
  // Be sure to add this line if initialize() call happens before runApp()
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();
  runApp(HomePage());
  const int helloAlarmID = 0;
  await AndroidAlarmManager.periodic(const Duration(minutes: 1), helloAlarmID, printHello);
}