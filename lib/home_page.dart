import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 45,left: 30,right: 30),
        child: Column(
          children: [
            _buildTop(),
            _buildInfoMessage(),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20,right: 20),
        child: _buildSpeedDial()
      ),
    );
  }


  var buttonSize = const Size(80,80);

  Widget _buildSpeedDial(){
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      spaceBetweenChildren: 30,
      backgroundColor: mainColor,
      overlayColor: Colors.black,
      overlayOpacity: 0.6,
      buttonSize: buttonSize,
      childrenButtonSize: buttonSize,
      children: [
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
          onTap: ()=>showModalBottomSheet<void>(
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top:Radius.circular(30.0))
              ),
              isScrollControlled: true,
              backgroundColor: Colors.white,
              builder: (context) => const AlarmSettingPage()
          ),
          backgroundColor: mainColor,
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
          onTap: ()=>showDialog(
            context: context,
            builder: (context) => const QuickSettingPage(),
          ),
          backgroundColor: mainColor,
        )
      ],
    );
  }

  Widget _buildTop(){
    return const Align(
      alignment: Alignment.topLeft,
      child: Text('Kant',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:48,
          letterSpacing: -2,
          fontFamily: "Roboto",
          color: mainColor,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildInfoMessage(){
      return Container(
        margin: const EdgeInsets.only(top:130),
        child: const Text(
          "알람이 없습니다.\n\n 아래 버튼을 눌러서\n알람을 생성합니다.",
          style: TextStyle(
            fontSize: 35.0,
            color: mainColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      );
  }

}
