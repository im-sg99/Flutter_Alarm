import 'package:flutter/material.dart';

class QuickSettingPage extends StatefulWidget {
  const QuickSettingPage({Key? key}) : super(key: key);

  @override
  State<QuickSettingPage> createState() => _QuickSettingPageState();
}

class _QuickSettingPageState extends State<QuickSettingPage> {

  double _volumeScale = 1.0;
  bool _setVibration = false;
  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 360,
        margin: const EdgeInsets.only(bottom: 20, left: 15, right:15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox.expand(
          child: Column(
            children: [
              _buildSizedBox(),
              const Text("퀵 알람",style: TextStyle(decoration: TextDecoration.none, color: Colors.black, fontSize: 30),),
              const Text("+00:00",style: TextStyle(decoration: TextDecoration.none, color: Colors.black),),
              _buildSizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _build1minute(),
                  _build5minute(),
                  _build10minute()
                ],
              ),
              _buildSizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _build15minute(),
                  _build30minute(),
                  _build1Hour()
                ],
              ),
              _buildSizedBox(),
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
              _buildSizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildResetButton(),
                  _buildSaveButton()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _build1minute(){
    return Container(
      width: 90,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: const Color(0xffC4C4C4),
      ),
      child: TextButton(
        onPressed: (){},
        child: const Text(
          "+1분",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
      ),
    );
  }

  Widget _build5minute() {
    return Container(
      width: 90,
      height: 50,
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: const Color(0xffC4C4C4),
      ),
      child: TextButton(
        onPressed: (){},
        child: const Text(
          "+5분",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
      ),
    );
  }

  Widget _build10minute() {
    return Container(
      width: 90,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: const Color(0xffC4C4C4),
      ),
      child: TextButton(
        onPressed: (){},
        child: const Text(
          "+10분",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
      ),
    );
  }

  Widget _build15minute(){
    return Container(
      width: 90,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: const Color(0xffC4C4C4),
      ),
      child: TextButton(
        onPressed: (){},
        child: const Text(
          "+15분",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
      ),
    );
  }

  Widget _build30minute() {
    return Container(
      width: 90,
      height: 50,
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: const Color(0xffC4C4C4),
      ),
      child: TextButton(
        onPressed: (){},
        child: const Text(
          "+30분",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
      ),
    );
  }

  Widget _build1Hour() {
    return Container(
      width: 90,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: const Color(0xffC4C4C4),
      ),
      child: TextButton(
        onPressed: (){},
        child: const Text(
          "+60분",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
      ),
    );
  }

  Widget _buildSizedBox(){
    return const SizedBox(
      height: 10,
    );
  }

  Widget _buildLine(){
    return Container(
      color: const Color(0xffE5EcE6),
      height: 3,
    );
  }

  Widget _volumeIcon(){
    return const Icon(Icons.volume_up,color: Color(0xff6524FF),size: 30,);
  }

  Widget _volumeSlider(){
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
    return const Icon(Icons.vibration, color: Color(0xff6524FF),size: 30,);
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

  Widget _buildResetButton(){
    return Container(
      width: 120,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: const Color(0xffCCD3E3),
      ),
      child: TextButton(
        onPressed: (){},
        child: const Center(
            child: Icon(Icons.refresh, color:Color(0xff000000), size: 30,),
        ),
      ),
    );
  }

  Widget _buildSaveButton(){
    return Container(
      margin: const EdgeInsets.only(left: 30),
      width: 180,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: const Color(0xff6524FF),
      ),
      child: TextButton(
        onPressed: (){
          Navigator.pop(context);
        },
        child: const Center(
            child: Text(
              '저장',
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
}
