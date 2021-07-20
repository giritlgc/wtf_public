import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:knowyourfood/custom_showcasewidget.dart';
import 'package:showcaseview/showcase_widget.dart';

import '../CommonComponents/common_functions.dart';
import '../CommonComponents/common_widget.dart';
import 'login.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // ignore: non_constant_identifier_names
  bool _valid_email = true;
  String _email;
  TextEditingController _textController = new TextEditingController();

  final keyOne = GlobalKey();
  final keyTwo = GlobalKey();
  final keyThree = GlobalKey();

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
                  'images/foodBackground4.jpeg',
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
              Stack(children: [
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
                          padding: EdgeInsets.fromLTRB(0, 62, 0, 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Trouble Logging In?",
                                  style: TextStyle(
                                    color: HexColor('#5ca4b8'),
                                    fontSize: 26,
                                    fontFamily: 'PlutoCondMedium',
                                  ),
                                ),
                              ])),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Enter your email and we'll send you",
                                  style: TextStyle(
                                    color: HexColor('#5ca4b8'),
                                    fontSize: 16,
                                    fontFamily: 'PlutoCondRegular',
                                  ),
                                ),
                              ])),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "a link to get back into your account",
                                  style: TextStyle(
                                    color: HexColor('#5ca4b8'),
                                    fontSize: 16,
                                    fontFamily: 'PlutoCondRegular',
                                  ),
                                ),
                              ])),
                      Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: CustomShowcaseWidget(
                            description: "Enter your registered email",
                            globalKey: keyOne,
                            child: Container(
                                height: 35,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 42.0, vertical: 2.0),
                                decoration: _valid_email
                                    ? BoxDecoration(
                                        color: HexColor('#edeef0'),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                      )
                                    : BoxDecoration(
                                        color: HexColor('#edeef0'),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        border: Border.all(color: Colors.red),
                                      ),
                                child: TextFormField(
                                  controller: _textController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(15, 0, 0, 10),
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                      color: HexColor('#e58149'),
                                      fontSize: 18,
                                      fontFamily: 'PlutoCondRegular',
                                    ),
                                  ),
                                  onChanged: (value) {
                                    _email = value;
                                  },
                                  validator: (value) {
                                    return null;
                                  },
                                ))),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(80, 32, 80, 20),
                          // padding: EdgeInsets.only(left:70,right:70),
                          decoration: BoxDecoration(),
                          child: CustomShowcaseWidget(
                              description: "Click on Submit",
                              globalKey: keyTwo,
                              child: FlatButton(
                                color: HexColor('#5ca4b8'),
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'PlutoCondMedium',
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                onPressed: () => {
                                  if (_email == null)
                                    {
                                      setState(() {
                                        _valid_email = false;
                                      })
                                    },
                                  if (_email.isNotEmpty &&
                                      validateEmail(_email))
                                    {
                                      FirebaseAuth.instance
                                          .sendPasswordResetEmail(email: _email)
                                          .then((value) => {
                                                showAlert(context,
                                                    "Please check your email for instructions to reset your password"),
                                                setState(() {
                                                  _email = '';
                                                  _valid_email = true;
                                                  _textController.text = '';
                                                })
                                              })
                                          .catchError((error) {
                                        showAlert(context,
                                            "Sorry, we could not find a user with email");
                                      })
                                    }
                                  else
                                    {
                                      setState(() {
                                        _valid_email = false;
                                      })
                                    }
                                },
                              ))),
                      Container(
                          padding: EdgeInsets.only(bottom: 60),
                          child: CustomShowcaseWidget(
                              description: "Go to Login Screen",
                              globalKey: keyThree,
                              child: InkWell(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'PlutoCondRegular',
                                    color: HexColor('#cfc8c5'),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => ShowCaseWidget(
                                              builder: Builder(
                                                  builder: (_) => Login()))));
                                },
                              ))),
                    ],
                  ),
                ),
                Positioned.fill(
                    child: Align(
                        alignment: Alignment(0, 1),
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
                        )))
              ]),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        ShowCaseWidget.of(context)
                            .startShowCase([keyOne, keyTwo, keyThree]);
                      },
                      color: Colors.white,
                      textColor: HexColor("#f38343"),
                      child: Text(
                        "?",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: EdgeInsets.all(8),
                      shape: CircleBorder(
                          side:
                              BorderSide(color: HexColor("#f38343"), width: 5)),
                    ),
                  ],
                ),
              )
            ]),
          ),
        )
      ]),
    );
  }
}
