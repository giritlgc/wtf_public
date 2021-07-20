import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:knowyourfood/Auth.dart';
import 'package:knowyourfood/Screens/logout_message.dart';
import 'package:knowyourfood/Screens/search_screen.dart';
import 'package:showcaseview/showcase_widget.dart';

class LogoutAlert extends StatefulWidget {
  @override
  _LogoutAlertState createState() => _LogoutAlertState();
}

class _LogoutAlertState extends State<LogoutAlert> {
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
                                "Do you want to",
                                style: TextStyle(
                                  color: HexColor('#f38343'),
                                  fontSize: 26,
                                  fontFamily: 'PlutoCondRegular',
                                ),
                              ),
                            ])),
                    Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "log out?",
                                style: TextStyle(
                                  color: HexColor('#f38343'),
                                  fontSize: 26,
                                  fontFamily: 'PlutoCondMedium',
                                ),
                              ),
                            ])),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      fontFamily: 'PlutoCondRegular',
                                      color: Colors.white),
                                ),
                              ),
                              color: HexColor('#5ca4b8'),
                              onPressed: () {
                                signOutUser().whenComplete(() => {
                                      setState(() {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ShowCaseWidget(
                                                        builder: Builder(
                                                            builder: (_) =>
                                                                SearchPage()))));
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LogoutMessage()));
                                      })
                                    });
                              },
                            ),
                            RaisedButton(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                      fontFamily: 'PlutoCondRegular',
                                      color: Colors.white),
                                ),
                              ),
                              color: HexColor("#f38343"),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ShowCaseWidget(
                                                builder: Builder(
                                                    builder: (_) =>
                                                        SearchPage()))));
                              },
                            )
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
