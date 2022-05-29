import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm/home_page.dart';
import 'package:flutter/services.dart';


class kantSplash extends StatelessWidget {
  const kantSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp(
      home:  AnimatedSplashScreen(
        splash: const Center(
          child: Text('Kant',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize:60,
              letterSpacing: -2,
              fontFamily: "Roboto",
              color: Color(0xff6524FF)
          ),
          ),
        ),
        nextScreen: const HomePage(),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
