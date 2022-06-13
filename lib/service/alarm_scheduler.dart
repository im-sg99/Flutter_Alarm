import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

import '../db/alarm_db.dart';

class AlarmScheduler {

  static Future<void> reschedule(int callbackId, DateTime time) async {
    await AndroidAlarmManager.cancel(callbackId);
    await _oneShot(callbackId, time);
    debugPrint('Rescheduled #$callbackId alarm at $time');
  }

  static Future<void> _oneShot(int id, DateTime time) async {
    await AndroidAlarmManager.oneShotAt(
      time,
      id,
      _emptyCallback,
      alarmClock: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }
}

void _emptyCallback() {}

extension TimeExtension on TimeOfDay {

  DateTime toComingDateTimeAt(int weekday) {
    final now = DateTime.now();
    final thisDateTime = DateTime(now.year, now.month, now.day, hour, minute);

    for (int days = 0; days < 7; ++days) {
      final candidate = thisDateTime.add(Duration(days: days));

      if ((candidate.weekday % 7) == weekday) {
        if (candidate.isBefore(now)) {
          return candidate.add(const Duration(days: 7));
        }
        return candidate;
      }
    }
    throw const FormatException("The weekday value must be in range 0..7");
  }
}