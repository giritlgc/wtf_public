import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:knowyourfood/Auth.dart';
import 'package:knowyourfood/Screens/forgot_password.dart';
import 'package:knowyourfood/Screens/registration.dart';
import 'package:knowyourfood/Screens/search_screen.dart';
import 'package:knowyourfood/custom_showcasewidget.dart';
import 'package:showcaseview/showcase_widget.dart';

import '../common_widget.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  bool valid_username = true;
  // ignore: non_constant_identifier_names
  bool valid_password = true;

  String username;
  String password;

  final keyOne = GlobalKey();
  final keyTwo = GlobalKey();
  final keyThree = GlobalKey();
  final keyFour = GlobalKey();
  final keyFive = GlobalKey();
  final keySix = GlobalKey();

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
      ListView(
        children: [
          Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                "What the Food?",
                style: TextStyle(
                    fontSize: 32,
                    // fontWeight: FontWeight.bold,
                    fontFamily: 'GrotaRoundedExtraBold',
                    color: Colors.white),
              ),
            ),
            Stack(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(15, 35, 15, 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                                child: CustomShowcaseWidget(
                              description: "Enter Registered email",
                              globalKey: keyOne,
                              child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Email         ",
                                        style: TextStyle(
                                          color: HexColor('#e58149'),
                                          fontSize: 22,
                                          fontFamily: 'PlutoCondMedium',
                                        ),
                                      ),
                                      
                                      Container(
                                        height: 35,
                                        decoration: valid_username
                                            ? BoxDecoration(
                                                color: HexColor('#edeef0'),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0)),
                                              )
                                            : BoxDecoration(
                                                color: HexColor('#edeef0'),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0)),
                                                border: Border.all(
                                                    color: Colors.red),
                                              ),
                                        child: SizedBox(
                                            width: 175,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        8, 0, 0, 15),
                                                border: InputBorder.none,
                                              ),
                                              onChanged: (value) {
                                                username = value;
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  setState(() {
                                                    valid_username = false;
                                                  });
                                                } else {
                                                  setState(() {
                                                    valid_username = true;
                                                  });
                                                }
                                                return null;
                                              },
                                            )),
                                      ),
                                    ]))),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child:  CustomShowcaseWidget(
                              description: "Enter your password",
                              globalKey: keyTwo,
                              child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Password",
                                        style: TextStyle(
                                          color: HexColor('#e58149'),
                                          fontSize: 22,
                                          fontFamily: 'PlutoCondMedium',
                                        ),
                                      ),
                                      
                                      Container(
                                        height: 35,
                                        decoration: valid_password
                                            ? BoxDecoration(
                                                color: HexColor('#edeef0'),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0)),
                                              )
                                            : BoxDecoration(
                                                color: HexColor('#edeef0'),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0)),
                                                border: Border.all(
                                                    color: Colors.red),
                                              ),
                                        child: SizedBox(
                                            width: 175,
                                            child: TextFormField(
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        8, 0, 0, 15),
                                                border: InputBorder.none,
                                              ),
                                              onChanged: (value) {
                                                password = value;
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  setState(() {
                                                    valid_password = false;
                                                  });
                                                } else {
                                                  setState(() {
                                                    valid_password = true;
                                                  });
                                                }
                                                return null;
                                              },
                                            )),
                                      ),
                                    ]))),
                            Container(
                                margin: EdgeInsets.fromLTRB(80, 50, 80, 20),
                                // padding: EdgeInsets.only(left:70,right:70),
                                decoration: BoxDecoration(),
                                child: CustomShowcaseWidget(
                              description: "Click on login",
                              globalKey: keyThree,
                              child:FlatButton(
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
                                          'Login',
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
                                    if (_formKey.currentState.validate())
                                      {
                                        if (username.isNotEmpty &&
                                            password.isNotEmpty)
                                          {
                                            FirebaseAuth.instance
                                                .signInWithEmailAndPassword(
                                                    email: username.trim(),
                                                    password: password.trim())
                                                .then((user) => Navigator.of(
                                                        context)
                                                    .pushReplacement(MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            ShowCaseWidget(
                                                                builder: Builder(
                                                                    builder: (_) =>
                                                                        SearchPage())))))
                                                .catchError((error) {
                                              print('Login Failed!');
                                              if (error.code ==
                                                  'user-not-found') {
                                                showAlert(context,
                                                    "Sorry, we could not find a user with email ");
                                              } else if (error.code ==
                                                  'wrong-password') {
                                                showAlert(context,
                                                    "Sorry, that's not the right password");
                                              } else {
                                                showAlert(context, error.code);
                                              }
                                            })
                                          }
                                      }
                                  },
                                ))),
                            MaterialButton(
                              padding: EdgeInsets.only(bottom: 20),
                              onPressed: () =>
                                  googleSignIn().then((value) async {
                                if (value) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ShowCaseWidget(
                                                  builder: Builder(
                                                      builder: (_) =>
                                                          SearchPage()))));
                                }
                              }),
                              child: CustomShowcaseWidget(
                              description: "Use existing Google account to sign-in",
                              globalKey: keyFour,
                              child:Image(
                                image: AssetImage('images/googleSignIn.png'),
                                width: 200.0,
                              )),
                            ),
                            // MaterialButton(
                            //   padding: EdgeInsets.only(bottom:1),
                            //   onPressed: () => signInWithFacebook().then((value) async {

                            //       if (value) {
                            //         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            //                                     SearchPage()), (Route<dynamic> route) => false);
                            //       }
                            //   }),
                            //   child: Image(
                            //     image: AssetImage('images/facebook.png'),
                            //     width: 220.0,
                            //   ),
                            // ),
                            CustomShowcaseWidget(
                              description: "If you forgot your password.Please click here",
                              globalKey: keyFive,
                              child: Container(
                                child:InkWell(
                              child: Text(
                                'Forgot password?',
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
                                        builder: (context) =>
                                            ShowCaseWidget(
            builder: Builder(builder: (_) =>ForgotPassword()))));
                              },
                                ))),
                            Container(
                                padding: EdgeInsets.only(bottom: 60),
                                child: CustomShowcaseWidget(
                              description: "Please click here for registration",
                              globalKey: keySix,
                              child:InkWell(
                                  child: Text(
                                    'Sign Up',
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
                                            builder: (context) =>
                                                ShowCaseWidget(
            builder: Builder(builder: (_) =>Registration()))));
                                  },
                                )))
                          ],
                        ))),
                Positioned.fill(
                    child: Align(
                        alignment: Alignment(0, 1.2),
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
              ],
            ),
              Padding(
                  padding: const EdgeInsets.only(bottom:20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          ShowCaseWidget.of(context).startShowCase([
                            keyOne,
                            keyTwo,
                            keyThree,
                            keyFour,
                            keyFive,
                            keySix
                          ]);
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
                          side: BorderSide(
                            color: HexColor("#f38343"),
                            width: 5)
                        ),
                      ),
                    ],
                  ),
                )
              
          ]),
        ],
      ),
    ]));
  }
}
