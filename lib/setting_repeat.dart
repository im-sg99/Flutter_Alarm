import 'package:flutter/material.dart';

class SettingRepeatPage extends StatefulWidget {
  const SettingRepeatPage({Key? key}) : super(key: key);

  @override
  State<SettingRepeatPage> createState() => _SettingRepeatPageState();
}

class _SettingRepeatPageState extends State<SettingRepeatPage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xffE5E5E5),
      content: SingleChildScrollView(
          child: ListBody(
            children: [
              Row(
                children: [
                  _buildTitle(),
                  _buildNotice()
                ],
              ),
              _sizedBoxH20(),
              _buildAlarmInfoDay(),
              Row(
                children: [
                  _buildTextButtonCancel(),
                  _buildTextButtonConfirm()
                ],
              )
            ],
          )
      ),
    );
  }

  Widget _buildTitle(){
    return const Text(
      '반복 설정',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    );
  }

  Widget _buildNotice(){
    return Container(
      margin: const EdgeInsets.only(left: 20),
        child: const Text(
            "에 울립니다.",
        )
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
          borderRadius: BorderRadius.circular(5.0),
          color: const Color(0xff6524FF),),
        child: const Center(
            child: Text(
              '확인',
              style: TextStyle(
                  color: Color(0xffFFFFFF),
                  fontSize: 22,
                  fontFamily: 'Roboto',
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
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold
              ),
            )
        ),
      ),
    );
  }

  Widget _buildAlarmInfoDay() {
    const size = 35.0;
    var _stateColor = Color(0xffA07BF8);
    var sun, mon, tue, wed, thu, fri, sat = false;
    return Row(
      children: ['월', '화', '수', '목', '금', '토', '일'].map(
            (day) => Container(
              margin: const EdgeInsets.all(2),
              width: size,
              height: size,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _stateColor == Color(0xffA07BF8) ? Color(0xff6524FF):Color(0xffA07BF8);
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(_stateColor),
                ),
                child: Text(
                  day,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
      ).toList(),
    );
  }

  Widget _sizedBoxH20(){
    return const SizedBox(
      height: 20,
    );
  }

}
