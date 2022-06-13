import 'package:flutter/material.dart';
import 'package:flutter_alarm/view/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionRequestScreen extends StatefulWidget {
  const PermissionRequestScreen({
    Key? key,
    required this.child,
    required this.preferences,
  }) : super(key: key);

  final Widget child;
  final SharedPreferences preferences;

  @override
  State<PermissionRequestScreen> createState() =>
      _PermissionRequestScreenState();
}

class _PermissionRequestScreenState extends State<PermissionRequestScreen> {
  static const String _isGrantedAllKey = "hasPermissionRequested";

  void _setPermission(BuildContext context) async {
    if (await Permission.systemAlertWindow.status != PermissionStatus.granted) {
      await Permission.systemAlertWindow.request();
    }

    final granted =
        await Permission.systemAlertWindow.status == PermissionStatus.granted;

    if (granted) {
      await widget.preferences.setBool(_isGrantedAllKey, true);
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const kantSplash()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.preferences.getBool(_isGrantedAllKey) ?? false) {
      return widget.child;
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                '알람 작동을 위한 \n"다른 앱 위에 표시"\n권한을 허용해주세요.',
              style: TextStyle(
                  color: Color(0xff6524FF),
                  fontSize: 22,
              ),),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                _setPermission(context);
              },
              child: const Text('설정하기'),
            ),
          ],
        ),
      ),
    );
  }
}