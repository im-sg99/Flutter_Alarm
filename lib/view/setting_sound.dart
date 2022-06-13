import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SettingSoundPage extends StatefulWidget {
  const SettingSoundPage({Key? key, required this.volumeNotifyParent, required this.vibrationNotifyParent}) : super(key: key);

  final Function(dynamic) volumeNotifyParent;
  final Function(dynamic) vibrationNotifyParent;

  @override
  State<SettingSoundPage> createState() => _SettingSoundPageState();
}

class _SettingSoundPageState extends State<SettingSoundPage> {

  //볼륨 크기를 결정
  double _setVolumeScale = 0.5;
  //진동 여부 결정
  bool _setVibration = false;
  //재생,일시 정지
  bool toggle = false;

  late final AudioCache _audioCache;

  @override
  void initState(){
    super.initState();
    _audioCache = AudioCache(
      prefix: 'assets/sounds/',
      fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    );
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xffE5E5E5),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children:[
                _volumeIcon(),
                _volumeSlider(),
                _playButton(),
                _containerLine(),
                _vibIcon(),
                _vibCheck(),
              ],
            ),
            Row(
              children: [
                _buildTextButtonCancel(),
                _buildTextButtonConfirm(),
              ],
            )
          ],
        ),
      ),
    );
  }

  //볼륨업 아이콘 입니다.
  Widget _volumeIcon(){
    return const Icon(Icons.volume_up,color: Color(0xff6524FF),);
  }

  //볼륨 설정입니다 슬라이더를 통해 _setVolumeScale 변수에 0~1까지의 값이 담깁니다.
  Widget _volumeSlider(){
    return SizedBox(
      width: 100,
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
          value: _setVolumeScale,
          onChanged: (value){
            setState(()=> _setVolumeScale = value);
          },
          min: 0,
          max: 1,
        ),
      ),
    );
  }

  //재생 버튼입니다 설정한 볼륨에 따라 알람음을 들을 수 있습니다. (미완)
  Widget _playButton(){
    return IconButton(
        onPressed: (){
          setState(() {
            toggle = !toggle;
          });
          if (toggle){
            _audioCache.play('alarmSound.mp3');
          }else{

          }
        },
        icon: toggle
            ?  const Icon(Icons.pause,
              size: 30,
              color: Color(0xff6524FF),)
            : const Icon(Icons.play_arrow,
              size: 30,
              color: Color(0xff6524FF),)
    );
  }

  //사운드 설정 부분과 진동 여부를 분리하기 위한 세로선을 그립니다.
  Widget _containerLine(){
    return Container(
      margin: const EdgeInsets.only(left: 10,right: 10),
      width: 3,
      height: 30,
      color: Colors.grey,
    );
  }

  //바이브레이션 아이콘 입니다.
  Widget _vibIcon(){
    return const Icon(Icons.vibration, color: Color(0xff6524FF),);
  }

  //진동 여부를 선택하는 체크박스 입니다.
  Widget _vibCheck(){
    return Checkbox(
        value: _setVibration,
        onChanged: (value){
          setState(() {
            _setVibration = !_setVibration;
          });
        }
    );
  }

  //저장 버튼 입니다. 누를 시 볼룸 크기와 진동여부를 상위 setting 페이에 전달합니다.
  Widget _buildTextButtonConfirm(){
    return TextButton(
      onPressed: (){
        widget.volumeNotifyParent(_setVolumeScale);
        widget.vibrationNotifyParent(_setVibration);
        Navigator.pop(context);
      },
      child: Container(
        width: 120,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: const Color(0xff6524FF),
        ),
        child: const Center(
            child: Text(
              '확인',
              style: TextStyle(
                  color: Color(0xffFFFFFF),
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            )
        ),
      ),
    );
  }

  //취소 버튼 입니다. 네비게이션 팝으로 이전 페이지로 이동합니다.
  Widget _buildTextButtonCancel(){
    return TextButton(
      onPressed: ()=>Navigator.pop(context),
      child: Container(
        width: 120,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: const Color(0xffCCD3E3),
        ),
        child: const Center(
            child: Text(
              '취소',
              style: TextStyle(
                  color: Color(0xff595959),
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            )
        ),
      ),
    );
  }
}

