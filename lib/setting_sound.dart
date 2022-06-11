import 'package:flutter/material.dart';

class SettingSoundPage extends StatefulWidget {
  const SettingSoundPage({Key? key}) : super(key: key);

  @override
  State<SettingSoundPage> createState() => _SettingSoundPageState();
}

class _SettingSoundPageState extends State<SettingSoundPage> {

  //볼륨크기
  double _volumeScale = 1.0;
  //진동여부
  bool _setVibration = false;
  //재생,멈춤
  bool toggle = false;

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


  Widget _volumeIcon(){
    return const Icon(Icons.volume_up,color: Color(0xff6524FF),);
  }

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
          value: _volumeScale,
          onChanged: (value){
            setState(()=> _volumeScale = value);
          },
          min: 0,
          max: 100,
        ),
      ),
    );
  }

  Widget _playButton(){
    return IconButton(
        onPressed: (){
          setState(() {
            toggle = !toggle;
          });
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

  Widget _vibIcon(){
    return const Icon(Icons.vibration, color: Color(0xff6524FF),);
  }

  Widget _containerLine(){
    return Container(
      margin: const EdgeInsets.only(left: 10,right: 10),
      width: 3,
      height: 30,
      color: Colors.grey,
    );
  }

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

  Widget _buildTextButtonConfirm(){
    return TextButton(
      onPressed: (){
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

