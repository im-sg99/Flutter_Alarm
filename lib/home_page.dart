import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var mainColor = const Color(0xff6524FF);
  var buttonSize = const Size(80,80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(40,50,40,40),
        child: Column(
          children: const [
            Text('Kant',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:48,
                letterSpacing: -2,
                fontFamily: "Roboto",
                color: Color(0xff6524FF),
              ),
            ),
            SizedBox(
              height:70,
            ),
            Text("아아아아"),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20,right: 20),
        child: SpeedDial(
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
              child: const Icon(
                Icons.alarm_add,
                size: 30,
                color: Colors.white,
              ),
              onTap: () {},
              backgroundColor: mainColor,
              label: '알람',
            ),
            SpeedDialChild(
              child:const Icon(
                Icons.alarm_sharp,
                size: 30,
                color: Colors.white,
              ),
              onTap: () {},
              backgroundColor: mainColor,
              label: '퀵설정',
            )
          ],
        ),
      ),
    );
  }
}
