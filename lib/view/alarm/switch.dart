import 'package:flutter/material.dart';
import '../../db/alarm_db.dart';

class AlarmSwitch extends StatefulWidget {
  const AlarmSwitch({Key? key, required this.alarm}) : super(key: key);
  final Alarm alarm;

  @override
  State<AlarmSwitch> createState() => _AlarmSwitchState();
}

class _AlarmSwitchState extends State<AlarmSwitch> {
  bool turn = false;

  @override
  Widget build(BuildContext context) {
    setState(() {
      turn = (widget.alarm.state == TurnAlarm.on.index);
    });
    return Transform.scale(
      scale: 1.5,
      child: Switch(
        value: turn,
        onChanged: (value) {
          AlarmDB db = AlarmDB();
          Alarm tmp = Alarm(
            id: widget.alarm.id,
            type: widget.alarm.type,
            time: widget.alarm.time,
            state: value ? TurnAlarm.on.index : TurnAlarm.off.index,
            label: widget.alarm.label,
          );
          setState(() {
            turn = value;
            db.updateAlarm(tmp);
          });
        },
      ),
    );;
  }
}
