import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor('#5ca4b8'),
      child: Center(child: SpinKitChasingDots(color: Colors.white, size: 50.0)),
    );
  }
}

class Buffering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor('#eff7f9'),
      child:
          Center(child: SpinKitCircle(color: HexColor('#5ca4b8'), size: 50.0)),
    );
  }
}
