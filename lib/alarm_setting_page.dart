import 'package:flutter/material.dart';
import 'package:flutter_alarm/setting_label.dart';
import 'package:flutter_alarm/setting_repeat.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class AlarmSettingPage extends StatefulWidget {

  const AlarmSettingPage({Key? key}) : super(key: key);
  @override
  State<AlarmSettingPage> createState() => AlarmSettingPageState();
}

class AlarmSettingPageState extends State<AlarmSettingPage> {
  String labelText='#일정';
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.82,
      child: Center(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildSaveButton(),
                _buildCloseButton()
              ],
            ),
            _buildTimePicker(),
            _buildLabelContainer(),
            _buildContainer1(),
            _buildContainer2()
          ],
        ),
      ),
    );
  }


  final _boxDeco = const BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),),
      color: Color(0xffe0e0e0),
      //박스 쉐도우 연습
      boxShadow: [BoxShadow(
        color: Colors.grey,
        spreadRadius: 1,
        blurRadius: 7,
        offset: Offset(1, 1),),]
  );

  Widget _buildSaveButton(){
    return TextButton(
      onPressed: (){},
      child: const Text("Save",
        style: TextStyle(color: Color(0xff6524FF),),
      ),
    );
  }

  Widget _buildCloseButton(){
    return IconButton(
      onPressed: ()=>Navigator.pop(context),
      icon: const Icon(
        Icons.clear,
        color: Colors.grey,
        size: 30,
      ),
    );
  }

  Widget _buildTimePicker(){
    return Container(
      margin: const EdgeInsets.only(top:20,bottom: 45),
      width: 250,
      height: 200,
      decoration: _boxDeco,
      child: TimePickerSpinner(
        is24HourMode: false,
        spacing: 30,
        normalTextStyle: const TextStyle(
          fontSize: 24,
          color: Color(0xffa8a8a8),
        ),
        highlightedTextStyle: const TextStyle(
          color: Color(0xff6524FF),
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        onTimeChange: (time){
          setState(() {
            _dateTime = time;
          });
        },
      ),
    );
  }

  Widget _buildLabelContainer(){
    return Container(
        padding: const EdgeInsets.only(left: 20,top: 4),
        margin: const EdgeInsets.only(bottom: 25),
        width:280,
        height: 65,
        decoration: _boxDeco,
        child: Row(
          children: [
            Column(
              children: [
                const SizedBox(
                  width: 190,
                  child: Text("라벨",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: Text(
                    labelText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              color: const Color(0xff6524FF),
              iconSize: 46,
              onPressed: ()=>showDialog(
                context: context,
                builder: (context)=> const SettingLabelPage(),
              ),
            ),
          ],
        )
    );
  }

  Widget _buildContainer1(){
    return Container(
      padding: const EdgeInsets.only(left: 20,top: 4),
      margin: const EdgeInsets.only(bottom: 25),
      width:280,
      height: 65,
      decoration: _boxDeco,
      child: Row(
        children: [
          const Icon(Icons.alarm, color:Color(0xff6524FF), size: 35,),
          const SizedBox(
            width: 50,
            child: Text('반복',
              style: TextStyle(
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 105,
            child: Text(
              labelText,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          IconButton(
            onPressed: ()=>showDialog(
            context: context,
            builder: (context)=>const SettingRepeatPage(),
            ),
            icon: const Icon(Icons.chevron_right),
            color: const Color(0xff6524FF),
            iconSize: 46,
          ),
        ],
      ),
    );
  }

  Widget _buildContainer2(){
    return Container(
      padding: const EdgeInsets.only(left: 20,top: 4),
      margin: const EdgeInsets.only(bottom: 25),
      width:280,
      height: 65,
      decoration: _boxDeco,
    );
  }

  void _changeLabel(text){
    setState(() {
      labelText = text;
    });
  }
}


