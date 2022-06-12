import 'package:flutter/material.dart';

const mainColor = Color(0xff6524FF);

class AlarmItem extends StatefulWidget {
  const AlarmItem({Key? key}) : super(key: key);

  @override
  State<AlarmItem> createState() => _AlarmItemState();
}

class _AlarmItemState extends State<AlarmItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildAlarmDeco(),
        _buildEmptyWidthSpace(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildAlarmInfo_time(),
            _buildAlarmLabel(),
            _buildAlarmInfo_day(),
          ],
        ),
        _buildEmptyWidthSpace(),
        _buildAlarmSwitch(),
      ],
    );
  }

  Widget _buildAlarmDeco() {
    return Column(
      children: const <Widget>[
        Text('⦁'),
        Text('⋮'),
        Text('⋮'),
        Text('⋮'),
      ],
    );
  }

  Widget _buildAlarmInfo_time() {
    return Text(
      '오전 00시 00분',
      style: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAlarmLabel() {
    return Text(
      '#label',
      style: TextStyle(
        fontSize: 20.0,
      ),
    );
  }

  Widget _buildAlarmInfo_day() {
    const size = 25.0;
    return Row(
      children: ['월', '화', '수', '목', '금', '토', '일'].map(
            (day) => Container(
          margin: EdgeInsets.all(4.5),
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
      ).toList(),
    );
  }

  Widget _buildAlarmSwitch() {
    bool isSwitched = false;  // State<MainPage> 의 프로퍼티로 위치해야함
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

Widget _buildEmptyWidthSpace() {
  return const SizedBox(
    width: 20.0,
  );
}
