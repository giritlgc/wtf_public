import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:knowyourfood/Auth.dart';
import 'package:knowyourfood/Screens/search_screen.dart';
import 'package:knowyourfood/custom_showcasewidget.dart';
import 'package:showcaseview/showcase_widget.dart';

import '../CommonComponents/common_widget.dart';
import '../CommonComponents/common_functions.dart';
import 'login.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  bool _valid_firstname = true;
  // ignore: non_constant_identifier_names
  bool _valid_surname = true;
  // ignore: non_constant_identifier_names
  bool _valid_email = true;
  // ignore: non_constant_identifier_names
  bool _valid_password = true;
  String _firstname;
  String _surname;
  String _email;
  String _password;

  final keyOne = GlobalKey();
  final keyTwo = GlobalKey();
  final keyThree = GlobalKey();
  final keyFour = GlobalKey();
  final keyFive = GlobalKey();
  final keySix = GlobalKey();
  final keySeven = GlobalKey();

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
        ListView(children: [
          Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 28),
              child: Text(
                "What the Food?",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'GrotaRoundedExtraBold',
                    color: Colors.white),
              ),
            ),
            Stack(children: [
              Container(
                margin: EdgeInsets.fromLTRB(15, 35, 15, 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Create a new",
                                style: TextStyle(
                                  color: HexColor('#5ca4b8'),
                                  fontSize: 28,
                                  fontFamily: 'PlutoCondMedium',
                                ),
                              ),
                            ])),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                        "account",
                        style: TextStyle(
                          color: HexColor('#5ca4b8'),
                          fontSize: 25,
                          fontFamily: 'PlutoCondMedium',
                        ),
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: CustomShowcaseWidget(
                                description: "Enter your first name",
                                globalKey: keyOne,
                                child: Container(
                                    height: 35,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 42.0, vertical: 2.0),
                                    decoration: _valid_firstname
                                        ? BoxDecoration(
                                            color: HexColor('#edeef0'),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          )
                                        : BoxDecoration(
                                            color: HexColor('#edeef0'),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                            border:
                                                Border.all(color: Colors.red)),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(15, 0, 0, 10),
                                        border: InputBorder.none,
                                        hintText: "First Name",
                                        hintStyle: TextStyle(
                                          color: HexColor('#e58149'),
                                          fontSize: 18,
                                          fontFamily: 'PlutoCondRegular',
                                        ),
                                      ),
                                      onChanged: (value) {
                                        _firstname = value;
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          setState(() {
                                            _valid_firstname = false;
                                          });
                                        } else {
                                          setState(() {
                                            _valid_firstname = true;
                                          });
                                        }
                                        return null;
                                      },
                                    )),
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: CustomShowcaseWidget(
                                description: "Enter your surname",
                                globalKey: keyTwo,
                                child: Container(
                                    height: 35,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 42.0, vertical: 2.0),
                                    decoration: _valid_surname
                                        ? BoxDecoration(
                                            color: HexColor('#edeef0'),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          )
                                        : BoxDecoration(
                                            color: HexColor('#edeef0'),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                            border:
                                                Border.all(color: Colors.red)),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(15, 0, 0, 10),
                                        border: InputBorder.none,
                                        hintText: "Last Name",
                                        hintStyle: TextStyle(
                                          color: HexColor('#e58149'),
                                          fontSize: 18,
                                          fontFamily: 'PlutoCondRegular',
                                        ),
                                      ),
                                      onChanged: (value) {
                                        _surname = value;
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          setState(() {
                                            _valid_surname = false;
                                          });
                                        } else {
                                          setState(() {
                                            _valid_surname = true;
                                          });
                                        }
                                        return null;
                                      },
                                    ))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: CustomShowcaseWidget(
                                description: "Enter your email",
                                globalKey: keyThree,
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
                                            border:
                                                Border.all(color: Colors.red),
                                          ),
                                    child: TextFormField(
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
                                        if (value.isEmpty) {
                                          setState(() {
                                            _valid_email = false;
                                          });
                                        } else {
                                          setState(() {
                                            _valid_email = validateEmail(value);
                                          });
                                        }
                                        return null;
                                      },
                                    ))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: CustomShowcaseWidget(
                                description: "Enter your password",
                                globalKey: keyFour,
                                child: Container(
                                    height: 35,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 42.0, vertical: 2.0),
                                    decoration: _valid_password
                                        ? BoxDecoration(
                                            color: HexColor('#edeef0'),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          )
                                        : BoxDecoration(
                                            color: HexColor('#edeef0'),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                            border:
                                                Border.all(color: Colors.red)),
                                    child: TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(15, 0, 0, 10),
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                          color: HexColor('#e58149'),
                                          fontSize: 18,
                                          fontFamily: 'PlutoCondRegular',
                                        ),
                                      ),
                                      onChanged: (value) {
                                        _password = value;
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          setState(() {
                                            _valid_password = false;
                                          });
                                        } else {
                                          setState(() {
                                            _valid_password = true;
                                          });
                                        }
                                        return null;
                                      },
                                    ))),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(80, 25, 80, 30),
                              // padding: EdgeInsets.only(left:70,right:70),
                              decoration: BoxDecoration(),
                              child: CustomShowcaseWidget(
                                  description:
                                      "Click Submit after you enter fields",
                                  globalKey: keyFive,
                                  child: FlatButton(
                                    color: HexColor('#5ca4b8'),
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(15.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Sign Up',
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
                                          if (_firstname.isNotEmpty &&
                                              _surname.isNotEmpty &&
                                              _email.isNotEmpty &&
                                              _password.isNotEmpty)
                                            {
                                              FirebaseAuth.instance
                                                  .createUserWithEmailAndPassword(
                                                      email: _email.trim(),
                                                      password:
                                                          _password.trim())
                                                  .then((currentUser) async => {
                                                        await currentUser.user
                                                            .updateProfile(
                                                                displayName:
                                                                    _firstname +
                                                                        " " +
                                                                        _surname),
                                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                            builder: (context) =>
                                                                ShowCaseWidget(
                                                                    builder: Builder(
                                                                        builder:
                                                                            (_) =>
                                                                                Login()))))
                                                      })
                                                  .catchError((error) {
                                                print('Registration Failed!');
                                                if (error.code ==
                                                    'email-already-in-use') {
                                                  showAlert(context,
                                                      "An account with this email already exists");
                                                } else if (error.code ==
                                                    "Invalid-email") {
                                                  showAlert(context,
                                                      "The e-mail entered is invalid");
                                                } else if (error.code ==
                                                    "weak-password") {
                                                  showAlert(context,
                                                      "This password is not valid");
                                                } else {
                                                  showAlert(
                                                      context, error.code);
                                                }
                                              })
                                            }
                                        }
                                    },
                                  ))),
                          SizedBox(
                            height: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          MaterialButton(
                            padding: EdgeInsets.only(bottom: 20),
                            onPressed: () => googleSignIn().then((value) async {
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
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                              child: CustomShowcaseWidget(
                                  description:
                                      "Use existing Google account for registration",
                                  globalKey: keySix,
                                  child: Image(
                                    image:
                                        AssetImage('images/googleSignUp.png'),
                                    width: 200.0,
                                    height: 40,
                                  )),
                            ),
                          ),
                          // MaterialButton(
                          //           padding: EdgeInsets.only(bottom:20),
                          //           onPressed: () => signInWithFacebook().then((value) async {

                          //               if (value) {
                          //                 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          //                                             SearchPage()), (Route<dynamic> route) => false);
                          //               }
                          //           }),
                          //           child: Image(
                          //             image: AssetImage('images/facebookSingUp.png'),
                          //             width: 205.0,
                          //             height: 40,
                          //           ),
                          //         ),
                          Container(
                              padding: EdgeInsets.only(bottom: 60),
                              child: CustomShowcaseWidget(
                                  description: "Go to Login Screen",
                                  globalKey: keySeven,
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
                                              builder: (context) =>
                                                  ShowCaseWidget(
                                                      builder: Builder(
                                                          builder: (_) =>
                                                              Login()))));
                                    },
                                  )))
                        ]))
                  ],
                ),
              ),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0, 1.15),
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
                      ShowCaseWidget.of(context).startShowCase([
                        keyOne,
                        keyTwo,
                        keyThree,
                        keyFour,
                        keyFive,
                        keySix,
                        keySeven
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
                        side: BorderSide(color: HexColor("#f38343"), width: 5)),
                  ),
                ],
              ),
            )
          ]),
        ]),
      ]),
    );
  }
}
