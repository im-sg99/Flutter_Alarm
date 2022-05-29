import 'package:flutter/material.dart';
import 'package:flutter_alarm/alarm_setting_page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    //위에 배터리 표시줄 안뜨게
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(40,50,40,40),
        child: Column(
          children: [
            _buildTop(),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20,right: 20),
        child: _buildSpeedDial()
      ),
    );
  }

  var mainColor = const Color(0xff6524FF);
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
      // childPadding: const EdgeInsets.only(right: 20),
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
              builder: (context) => const AlarmSettingPage(labelText: '#일정',)
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
          onTap: () {},
          backgroundColor: mainColor,
        )
      ],
    );
  }

  Widget _buildTop(){
    return const Text('Kant',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize:48,
        letterSpacing: -2,
        fontFamily: "Roboto",
        color: Color(0xff6524FF),
      ),
    );
  }
}
