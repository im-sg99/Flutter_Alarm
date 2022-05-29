import 'package:flutter/material.dart';

class SettingLabelPage extends StatefulWidget {
  const SettingLabelPage({Key? key}) : super(key: key);

  @override
  State<SettingLabelPage> createState() => _SettingLabelPageState();
}

class _SettingLabelPageState extends State<SettingLabelPage> {

  final TextEditingController _labelTextEditController = TextEditingController();
  String labelText = '';

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      backgroundColor: const Color(0xffE5E5E5),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            _buildTitle(),
            _buildTextField(),
            Row(
              children: [
                _buildTextButtonCancel(),
                _buildTextButtonConfirm(),
              ],
            )
          ],
        )
      ),
    );
  }
  @override
  void dispose(){
    _labelTextEditController.dispose();
    super.dispose();
  }

  Widget _buildTitle(){
    return const Text(
      '라벨 설정',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    );
  }

  Widget _buildTextButtonConfirm(){
    return TextButton(
      onPressed: (){

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

  Widget _buildTextField(){
    return TextField(
      controller: _labelTextEditController,
      decoration: const InputDecoration(
        hintText: "라벨을 입력하세요.",
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6524FF))
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff6524FF),width: 2),
        ),
      ),

    );
  }
}


