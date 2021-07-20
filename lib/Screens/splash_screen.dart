import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'package:knowyourfood/Screens/search_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => ShowCaseWidget(
            builder: Builder(builder: (_) => SearchPage())))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#e9ce3f'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              'images/charaka.png',
              width: 150,
              height: 150,
            )),
            Text(
              "What the Food?",
              style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'GrotaRoundedExtraBold',
                  color: Colors.white),
            ),
          ],
        ));
  }
}
