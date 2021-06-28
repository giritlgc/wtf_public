import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:knowyourfood/Screens/search_screen.dart';
import 'package:showcaseview/showcase_widget.dart';

class LogoutMessage extends StatefulWidget {
  @override
  _LogoutMessageState createState() => _LogoutMessageState();
}

class _LogoutMessageState extends State<LogoutMessage> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Material(
      child: Stack(children: [
        ListView(children: [
          Column(
            children: [
              Container(
                height: _height / 2,
                width: _width,
                color: HexColor('#e9ce3f'),
              ),
              Container(
                child: Image.asset(
                  'images/foodBackground.jpeg',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ]),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: ListView(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "What the Food?",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 32,
                        fontFamily: 'GrotaRoundedExtraBold',
                        color: Colors.white),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 35, 15, 50),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: HexColor('#e9ce3f'),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        padding: EdgeInsets.all(1),
                        child: Image.asset(
                          'images/charaka.png',
                          width: 90,
                          height: 90,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "User ",
                                style: TextStyle(
                                  color: HexColor('#f38343'),
                                  fontSize: 26,
                                  fontFamily: 'PlutoCondRegular',
                                ),
                              ),
                              Text(
                                "Logged out!",
                                style: TextStyle(
                                  color: HexColor('#f38343'),
                                  fontSize: 26,
                                  fontFamily: 'PlutoCondMedium',
                                ),
                              ),
                            ])),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 50),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(45, 8, 45, 8),
                                child: Text(
                                  "Ok",
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontFamily: 'PlutoCondRegular',
                                      color: Colors.white),
                                ),
                              ),
                              color: HexColor('#5ca4b8'),
                              shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                              onPressed: () {
                                // Navigator.of(context).pushAndRemoveUntil(
                                //     MaterialPageRoute(
                                //         builder: (context) => SearchPage()),
                                //     (Route<dynamic> route) => false);
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => ShowCaseWidget(
            builder: Builder(builder: (_) => SearchPage()))));
                              },
                            ),
                          ]),
                    )
                  ],
                ),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}
