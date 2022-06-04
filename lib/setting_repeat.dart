import 'package:flutter/material.dart';

class SettingRepeatPage extends StatefulWidget {
  const SettingRepeatPage({Key? key}) : super(key: key);

  @override
  State<SettingRepeatPage> createState() => _SettingRepeatPageState();
}

class _SettingRepeatPageState extends State<SettingRepeatPage> {

  // 버튼 색변경에 사용되는 프로퍼티
 var stateColor = MaterialStateProperty.all(const Color(0xffA07BF8));
  var stateColorPressed = MaterialStateProperty.all(const Color(0xff6524FF));
  List<bool> pressed = List<bool>.filled(7, false);
  final List _days =['월', '화', '수', '목', '금', '토', '일'];

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
                  Column(
                    children: [
                      _buildNotice(),
                      _buildNotice2(),
                    ],
                  )
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

  Widget _buildTitle() {
    return const Text(
      '반복 설정',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    );
  }

  Widget _buildNotice() {
    return Container(
        margin: const EdgeInsets.only(left: 0),
        child: Text(
          '요일 들어갈 곳 ',
        )
    );
  }

  Widget _buildNotice2() {
    return Container(
        margin: const EdgeInsets.only(left: 0),
        child: const Text(
          '에 울립니다.',
        )
    );
  }

  Widget _buildTextButtonConfirm() {
    return TextButton(
      onPressed: () {
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

  Widget _buildTextButtonCancel() {
    return TextButton(
      onPressed: () => Navigator.pop(context),
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

    return Row(
      children: _days.asMap().entries.map(
              (day) => Container(
            margin: const EdgeInsets.all(2),
            width: size,
            height: size,
            child: TextButton(
              onPressed: () {
                setState(() {
                  pressed[day.key] = !pressed[day.key];
                });
              },
              style: ButtonStyle(
                backgroundColor: pressed[day.key] ? stateColorPressed : stateColor
              ),
              child: Text(
                day.value,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
      ).toList(),
    );
  }

  Widget _sizedBoxH20() {
    return const SizedBox(
      height: 20,
    );
  }

}
