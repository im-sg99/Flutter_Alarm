import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alarm/alarm_db.dart';
import 'package:flutter_alarm/alarm_quick_setting.dart';
import 'package:flutter_alarm/alarm_setting_page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

const mainColor = Color(0xff6524FF);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Alarm> alarmList = [];

  void updateNum() async {
    AlarmDB db = AlarmDB();
    var data = await db.read();
    setState(() {
      alarmList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    // <진동민: 추가>
    // 상태바 배경색깔 바꾸기
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xff6524FF),
      ),
    );

    const paddingVal = 20.0;
    updateNum();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 45.0,
              bottom: paddingVal,
              right: paddingVal,
              left: paddingVal),
          child: _buildScreen(),
        ),
      ),
      floatingActionButton: _buildSpeedDial(),
    );
  }

  Widget _buildSpeedDial() {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      spaceBetweenChildren: 30,
      backgroundColor: mainColor,
      overlayColor: Colors.black,
      overlayOpacity: 0.6,
      buttonSize: const Size(80.0, 80.0),
      childrenButtonSize: const Size(80.0, 80.0),
      closeManually: false,
      children: <SpeedDialChild>[
        SpeedDialChild(
          child: const Text(
            "알람",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: mainColor,
          onTap: () => showModalBottomSheet<void>(
            context: context,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(30.0))),
            isScrollControlled: true,
            backgroundColor: Colors.white,
            builder: (context) => const AlarmSettingPage(),
          ),
        ),
        SpeedDialChild(
          child: const Text(
            "퀵 알람",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: mainColor,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => QuickSettingPage(num: alarmList.length),
            );
          },
        )
      ],
    );
  }

  Widget _buildTop() {
    return const Align(
      alignment: Alignment.topLeft,
      child: Text(
        'Kant',
        style: TextStyle(
          fontSize: 50.0,
          fontWeight: FontWeight.bold,
          fontFamily: "Roboto",
          color: mainColor,
          letterSpacing: -2,
        ),
      ),
    );
  }

  Widget _buildInfoMessage(
      {required StateAlarm state, int hourRemain = 0, int minRemain = 0}) {
    var textStyle = const TextStyle(
      fontSize: 35.0,
      color: mainColor,
      fontWeight: FontWeight.bold,
    );

    switch (state) {
      case StateAlarm.active:
        int hour = hourRemain;
        int min = minRemain;

        if (hour == 0) {
          return Text(
            '다음 알람 $min분 후',
            style: textStyle,
            textAlign: TextAlign.center,
          );
        } else {
          return Text(
            '다음 알람\n$hour시간 $min분 후',
            style: textStyle,
            textAlign: TextAlign.center,
          );
        }

      case StateAlarm.inactive:
        return Text(
          '모든 알람이 꺼진\n상태입니다',
          style: textStyle,
          textAlign: TextAlign.center,
        );

      case StateAlarm.nothing:
        return Container(
          margin: const EdgeInsets.only(top: 130),
          child: Text(
            "알람이 없습니다.\n\n아래 버튼을 눌러서\n알람을 생성합니다",
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        );
    }
  }

  Widget _buildHeightSpace() {
    return const SizedBox(
      height: 35.0,
    );
  }

  Widget _buildWidthSpace() {
    return const SizedBox(
      width: 20.0,
    );
  }

  // Alarm UI 기능 구현
  // ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
  Widget _buildScreen() {
    late StateAlarm state;
    var result = false;
    result = alarmList.any((e) => TurnAlarm.on.index == e.state);

    var timeRemain = DateTime.now();

    if (alarmList.isEmpty) {
      // 데이터베이스에서 받아온 알람리스트가 비어있다면 nothing
      state = StateAlarm.nothing;
    } else if (result) {
      // 알람리스트가 비어있지 않고, 알람이 하나라도 켜진 경우
      state = StateAlarm.active;
      var timeList = alarmList.map((e) {
        DateTime tmp = DateTime.parse(e.time);
        return tmp.millisecondsSinceEpoch;
      }).toList();
      var timeMinValue = timeList.reduce(min);
      var now = DateTime.now().millisecondsSinceEpoch;
      timeRemain = DateTime.fromMillisecondsSinceEpoch(timeMinValue - now);
    } else {
      state = StateAlarm.inactive;
    }

    int hourRemain = timeRemain.hour;
    int minRemain = timeRemain.minute;

    return Column(
      children: <Widget>[
        _buildTop(),
        _buildHeightSpace(),
        _buildInfoMessage(
            state: state, hourRemain: hourRemain, minRemain: minRemain),
        _buildHeightSpace(),
        ...alarmList.map((alarm) => _buildAlarm(alarm)).toList(),
      ],
    );
  }

  Widget _buildAlarm(Alarm alarm) {
    if (alarm.type == AlarmType.quick.index) {
      return Column(
        children: <Widget>[
          _buildQuickAlarm(alarm),
          _buildHeightSpace(),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          _buildNormalAlarm(alarm),
          _buildHeightSpace(),
        ],
      );
    }
  }

  Widget _buildQuickAlarm(Alarm alarm) {
    return Row(
      children: <Widget>[
        _buildAlarmDeco('⦁⋮⋮'),
        _buildWidthSpace(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildAlarmInfo_time(time: alarm.time),
            _buildAlarmLabel(label: alarm.label),
          ],
        ),
        const SizedBox(
          width: 95.0,
        ),
        _buildAlarmSwitch(),
      ],
    );
  }

  Widget _buildNormalAlarm(Alarm alarm) {
    return Row(
      children: <Widget>[
        _buildAlarmDeco('⦁⋮⋮⋮'),
        _buildWidthSpace(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildAlarmInfo_time(time: alarm.time),
            _buildAlarmLabel(label: alarm.label),
            _buildAlarmInfo_day(),
          ],
        ),
        _buildWidthSpace(),
        _buildAlarmSwitch(),
      ],
    );
  }

  Widget _buildAlarmDeco(String str) {
    List<String> deco = str.split('');
    return Column(
      children: deco
          .map(
            (ch) => Text(ch),
          )
          .toList(),
    );
  }

  Widget _buildAlarmInfo_time({required String time}) {
    DateTime savedTime = DateTime.parse(time);
    String whichMeridiem = savedTime.hour >= 12 ? '오후' : '오전';
    int hour = savedTime.hour % 12;
    int min = savedTime.minute;
    String timeStr = '$whichMeridiem $hour시 $min분';
    return Text(
      timeStr,
      style: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAlarmLabel({required String label}) {
    return Text(
      '#$label',
      style: const TextStyle(
        fontSize: 20.0,
      ),
    );
  }

  Widget _buildAlarmInfo_day() {
    const size = 25.0;
    return Row(
      children: ['월', '화', '수', '목', '금', '토', '일']
          .map(
            (day) => Container(
              margin: const EdgeInsets.all(4.5),
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: mainColor,
              ),
              child: Center(
                child: Text(
                  day,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildAlarmSwitch() {
    bool isSwitched = false; // State<MainPage> 의 프로퍼티로 위치해야함
    return Transform.scale(
      scale: 1.5,
      child: Switch(
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
          });
        },
      ),
    );
  }
}
