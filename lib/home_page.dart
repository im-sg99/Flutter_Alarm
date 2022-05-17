import 'dart:ui';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(40,50,40,40),
        child: Column(
          children: const [
            Text('Kant',
              style: TextStyle(fontWeight: FontWeight.bold,
              fontSize:48,
              fontFamily: "Roboto",
              color: Color(0xff6524FF),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30,right: 30),
        child: SizedBox(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            child: const Icon(
              Icons.add,
              size: 35,
            ),
            onPressed: (){},
            backgroundColor: const Color(0xff6524FF),
          ),
        ),
      ),
    );
  }
}
