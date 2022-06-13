import 'package:flutter/material.dart';
import 'package:flutter_alarm/view/setting_label.dart';
import 'package:flutter_alarm/view/setting_repeat.dart';
import 'package:flutter_alarm/view/setting_sound.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class AlarmSettingPage extends StatefulWidget {

  const AlarmSettingPage({Key? key}) : super(key: key);
  @override
  State<AlarmSettingPage> createState() => AlarmSettingPageState();
}

class AlarmSettingPageState extends State<AlarmSettingPage> {
  String _labelText = '라벨 텍스트';
  List<String> _dayList = ['','','','','','',''];
  DateTime _dateTime = DateTime.now(); //타임피커에서 현재 시각을 받아와 띄움
  var _volumeScale = 0.5;
  bool _vibration = false;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.86,
      child: Center(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _slidingUpPanelIcon(),
                _buildSaveButton(),
                _buildCloseButton()
              ],
            ),
            _buildTimePicker(),
            _buildLabelContainer(),
            _buildRepeatContainer(),
            _buildSoundContainer()
          ],
        ),
      ),
    );
  }

  //컨테이너의 모양을 정의합니다.
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

  //저장 버튼입니다. (미완)
  Widget _buildSaveButton(){
    return TextButton(
      onPressed: (){},
      child: const Text("Save",
        style: TextStyle(color: Color(0xff6524FF),),
      ),
    );
  }

  //취소 버튼입니다. 메인화면으로 돌아갑니다.
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

  //시간을 선택할 수 있는 위젯입니다
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

  //라벨링에 설정 내용을 보여주고 설정 화면으로 이동하는 컨테이너입니다.
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
                    '#$_labelText',
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
                builder: (context)=> SettingLabelPage(labelNotifyParent: _changeLabel),
              ),
            ),
          ],
        )
    );
  }

  //반복할 요일을 선택하는 화면으로 이동하는 컨테이너입니다.
  Widget _buildRepeatContainer(){
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
              _dayList.join(''),
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          IconButton(
            onPressed: ()=>showDialog(
            context: context,
            builder: (context)=> SettingRepeatPage(repeatNotifyParent: _changeDay),
            ),
            icon: const Icon(Icons.chevron_right),
            color: const Color(0xff6524FF),
            iconSize: 46,
          ),
        ],
      ),
    );
  }

  //소리 및 진동을 설정하는 화면으로 이동하는 컨테이너입니다.
  Widget _buildSoundContainer(){
    return Container(
      padding: const EdgeInsets.only(left: 20,top: 4),
      margin: const EdgeInsets.only(bottom: 25),
      width:280,
      height: 65,
      decoration: _boxDeco,
      child: Row(
        children: [
          const SizedBox(
            width: 190,
            child: Text('소리 및 진동 설정',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: ()=>showDialog(
              context: context,
              builder: (context)=> SettingSoundPage(volumeNotifyParent: _changeVol,vibrationNotifyParent: _changeVib,),
            ),
            icon: const Icon(Icons.chevron_right),
            color: const Color(0xff6524FF),
            iconSize: 46,
          ),
        ],
      ),
    );
  }

  //하위 클래스 페이지에서 설정힌 값을 클래스 변수로 받아옵니다.
  void _changeLabel(text){
    setState(() {
      _labelText = text;
    });
  }

  //하위 클래스 페이지에서 설정힌 값을 클래스 변수로 받아옵니다.
  void _changeDay(list){
    setState(() {
      _dayList = list;
    });
  }

  //하위 클래스 페이지에서 설정힌 값을 클래스 변수로 받아옵니다.
  void _changeVol(volume){
    setState(() {
      _volumeScale = volume;
    });
  }

  //하위 클래스 페이지에서 설정힌 값을 클래스 변수로 받아옵니다.
  void _changeVib(vib){
    setState(() {
      _vibration = vib;
    });
  }

  //상위 슬라이딩업패널(-) 아이콘을 그립니다.
  Widget _slidingUpPanelIcon(){
    return Container(
      margin: const EdgeInsets.only(right: 70),
      width: 40,
      height: 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffC4C4C4),
      ),
    );
  }
}


