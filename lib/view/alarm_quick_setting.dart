import 'package:flutter/material.dart';
import 'package:flutter_alarm/db/alarm_db.dart';

class QuickSettingPage extends StatefulWidget {
  const QuickSettingPage({Key? key, required this.num}) : super(key: key);
  final int num;

  @override
  State<QuickSettingPage> createState() => _QuickSettingPageState();
}

class _QuickSettingPageState extends State<QuickSettingPage> {
  double _volumeScale = 1.0;
  bool _setVibration = false;
  bool _toggle = false; // toggle -> _toggle <진동민 : 변경>
  int _time = 0;

  @override
  Widget build(BuildContext context) {
    String hourStr = '${_time ~/ 60}'.padLeft(2, '0');
    String minStr = '${_time % 60}'.padLeft(2, '0');
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 360,
        margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10), // 20 -> 10 <진동민: 변경>
        ),
        child: SizedBox.expand(
          child: Column(
            children: [
              _buildHeightBox(),
              const Text(
                "퀵 알람",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              Text( // const 제거 <진동민: 변경>
                '+$hourStr:$minStr', // "+00:00" <진동민: 변경>
                style: const TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black
                ),
              ),
              _buildHeightBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildMinBtn(min: 1),
                  _buildWidthBox(),
                  _buildMinBtn(min: 5),
                  _buildWidthBox(),
                  _buildMinBtn(min: 10),
                ],
              ),
              _buildHeightBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildMinBtn(min: 15),
                  _buildWidthBox(),
                  _buildMinBtn(min: 30),
                  _buildWidthBox(),
                  _buildMinBtn(min: 60),
                ],
              ),
              _buildHeightBox(),
              _buildLine(),
              Material(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _volumeIcon(),
                    _volumeSlider(),
                    _playButton(),
                    _containerLine(),
                    _vibIcon(),
                    _vibCheck(),
                  ],
                ),
              ),
              _buildHeightBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildResetBtn(),
                  _buildSaveBtn(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMinBtn({required int min}) {  // <진동민 : 추가>
    return Container(
      width: 90,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: const Color(0xffC4C4C4),
      ),
      child: TextButton(
        child: Text(
          "+$min분",
          style: const TextStyle(
            fontSize: 23, // 18 -> 23 <진동민: 변경>
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        onPressed: () {
          setState(() {
            _time += min;
          });
        },
      ),
    );
  }

  Widget _buildHeightBox() {  // <진동민: 함수이름변경>
    return const SizedBox(
      height: 10,
    );
  }

  Widget _buildWidthBox() { // <진동민: 추가>
    return const SizedBox(
      width: 20,
    );
  }

  Widget _buildLine() {
    return Container(
      color: const Color(0xffE5EcE6),
      height: 3,
    );
  }

  Widget _volumeIcon() {
    return const Icon(
      Icons.volume_up,
      color: Color(0xff6524FF),
      size: 30,
    );
  }

  Widget _volumeSlider() {
    return SizedBox(
      width: 150,
      height: 2,
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: const Color(0xff6c30ff),
          inactiveTrackColor: const Color(0xffcab3ff),
          trackHeight: 2.0,
          thumbColor: const Color(0xff6524FF),
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
          overlayColor: Colors.purple.withAlpha(32),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 1.0),
        ),
        child: Slider(
          value: _volumeScale,
          onChanged: (value) {
            setState(() => _volumeScale = value);
          },
          min: 0,
          max: 100,
        ),
      ),
    );
  }

  Widget _playButton() {
    return IconButton(
        onPressed: () {
          setState(() {
            _toggle = !_toggle;
          });
        },
        icon: _toggle
            ? const Icon(
          Icons.pause,
          size: 30,
          color: Color(0xff6524FF),
        )
            : const Icon(
          Icons.play_arrow,
          size: 30,
          color: Color(0xff6524FF),
        )
    );
  }

  Widget _containerLine() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      width: 3,
      height: 30,
      color: const Color(0xffE5ECE6), // 색변경 <진동민:변경>
    );
  }

  Widget _vibIcon() {
    return const Icon(
      Icons.vibration,
      color: Color(0xff6524FF),
      size: 30,
    );
  }

  Widget _vibCheck() {
    return Checkbox(
        value: _setVibration,
        onChanged: (value) {
          setState(() {
            _setVibration = !_setVibration;
          });
        }
    );
  }

  Widget _buildResetBtn() { // 이름 변경 <진동민: 변경>
    return Container(
      width: 120,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: const Color(0xffCCD3E3),
      ),
      child: TextButton(
        child: const Center(
          child: Icon(
            Icons.refresh,
            color: Colors.black,
            size: 30,
          ),
        ),
        onPressed: () {
          setState(() {
            _time=0;
          });
        },
      ),
    );
  }

  Widget _buildSaveBtn() {
    return Container(
      margin: const EdgeInsets.only(left: 30),
      width: 190, // 180 -> 190으로 변경 <진동민: 변경>
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: const Color(0xff6524FF),
      ),
      child: TextButton(
        onPressed: saveQuickAlarm,
        child: const Center(
          child: Text(
            '저장',
            style: TextStyle(
              color: Colors.white, // <진동민: 변경>
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveQuickAlarm() async {
    Navigator.pop(context);
    AlarmDB db = AlarmDB();
    // db.reset();
    DateTime now = DateTime.now();
    now = now.add(Duration(minutes: _time));
    debugPrint(now.toString());
    DateTime currentTime = DateTime(now.year, now.month, now.day, now.hour, now.minute);

    var alarm = Alarm(
      id: widget.num,
      type: AlarmType.quick.index,
      time: currentTime.toString(),
      state: TurnAlarm.on.index,
      label: '퀵 알람',
    );
    await db.insertAlarm(alarm);
  }
}