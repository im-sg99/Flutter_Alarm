import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class AlarmSettingPage extends StatefulWidget {
  const AlarmSettingPage({Key? key}) : super(key: key);

  @override
  State<AlarmSettingPage> createState() => _AlarmSettingPageState();
}

class _AlarmSettingPageState extends State<AlarmSettingPage> {
  var boxDeco = const BoxDecoration(
    borderRadius: BorderRadius.all(
     Radius.circular(20.0),
    ),
    color: Color(0xffe0e0e0),
    //박스 쉐도우 연습
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
        spreadRadius: 1,
        blurRadius: 7,
        offset: Offset(1, 1),
      )
    ]
);

  @override
  Widget build(BuildContext context) {

    DateTime _dateTime = DateTime.now();

    return FractionallySizedBox(
      heightFactor: 0.82,
      child: Container(
        padding: EdgeInsets.only(top:65),
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    height: 200,
                    decoration: boxDeco,
                    child: TimePickerSpinner(
                      is24HourMode: false,
                      highlightedTextStyle: const TextStyle(
                        color: Color(0xff6524FF),
                        fontSize: 34,
                      ),
                      onTimeChange: (time){
                        setState(() {
                          _dateTime = time;
                        });
                      },
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 45,
              ),
              Container(
                padding: EdgeInsets.only(left: 10,top: 2),
                margin: EdgeInsets.only(bottom: 25),
                width:280,
                height: 65,
                decoration: boxDeco,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 200,
                            child: const Text("라벨",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'roboto',
                            ),
                            ),
                        ),
                        Container(
                          width: 200,
                            child: Text("#일정",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'roboto',
                              ),
                            ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.chevron_right),
                      color: Color(0xff6524FF),
                      iconSize: 46,
                      onPressed: (){},
                    ),
                  ],
                )
              ),
              Container(
                padding: EdgeInsets.only(left: 10,top: 2),
                margin: EdgeInsets.only(bottom: 25),
                width:280,
                height: 65,
                decoration: boxDeco,
              ),
              Container(
                padding: EdgeInsets.only(left: 10,top: 2),
                margin: EdgeInsets.only(bottom: 25),
                width:280,
                height: 65,
                decoration: boxDeco,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


