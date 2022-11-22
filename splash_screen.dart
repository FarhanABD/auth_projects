import 'dart:async';

import 'home_screen.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:project_final/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'image/asset/yinyang.png',
            width: 180,
            height: 180,
          ),
        ]),
      ),
    );
  }
}
