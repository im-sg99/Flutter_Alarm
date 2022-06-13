import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm/service/alarm_list_provider.dart';
import 'package:flutter_alarm/service/alarm_polling_worker.dart';
import 'package:flutter_alarm/service/alarm_state.dart';
import 'package:flutter_alarm/view/alarm_screen_service/alarm_observer.dart';
import 'package:flutter_alarm/view/alarm_screen_service/permission_request_screen.dart';
import 'package:flutter_alarm/view/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db/alarm_db.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();

  final AlarmState alarmState = AlarmState();

  // 앱 진입시 알람 탐색을 시작해야 한다.
  AlarmPollingWorker().createPollingWorker(alarmState);

  //final List<Alarm> alarms = await AlarmDB().read() ?? [];  //<-

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => alarmState),
      //ChangeNotifierProvider(create: (context) => AlarmListProvider(alarms)),
    ],
    child: MyApp(preferences: await SharedPreferences.getInstance()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.preferences}) : super(key: key);

  final SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PermissionRequestScreen(
          preferences: preferences,
          child: const AlarmObserver(child: kantSplash()),
          ),
    );
  }
}
