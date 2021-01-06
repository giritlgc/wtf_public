import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:knowyourfood/login.dart';

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

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  showAlertDialog(BuildContext context, String message) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Registration Failed!"),
          content: Text(message),
          actions: [
            okButton,
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: HexColor('#e9ce3f'),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 52),
            child: Text(
              "Know Your Food.",
              style: TextStyle(
                  fontSize: 47,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ColbyCompressed',
                  color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 35, 15, 0),
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
                              color: HexColor('#72a633'),
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
                      color: HexColor('#72a633'),
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
                        child: Container(
                            height: 35,
                            padding: EdgeInsets.fromLTRB(15, 16, 0, 0),
                            margin: EdgeInsets.symmetric(
                                horizontal: 42.0, vertical: 2.0),
                            decoration: _valid_firstname
                                ? BoxDecoration(
                                    color: HexColor('#edeef0'),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  )
                                : BoxDecoration(
                                    color: HexColor('#edeef0'),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    border: Border.all(color: Colors.red)),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "First name",
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Container(
                            height: 35,
                            padding: EdgeInsets.fromLTRB(15, 16, 0, 0),
                            margin: EdgeInsets.symmetric(
                                horizontal: 42.0, vertical: 2.0),
                            decoration: _valid_surname
                                ? BoxDecoration(
                                    color: HexColor('#edeef0'),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  )
                                : BoxDecoration(
                                    color: HexColor('#edeef0'),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    border: Border.all(color: Colors.red)),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Surname",
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
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Container(
                            height: 35,
                            padding: EdgeInsets.fromLTRB(15, 16, 0, 0),
                            margin: EdgeInsets.symmetric(
                                horizontal: 42.0, vertical: 2.0),
                            decoration: _valid_email
                                ? BoxDecoration(
                                    color: HexColor('#edeef0'),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  )
                                : BoxDecoration(
                                    color: HexColor('#edeef0'),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    border: Border.all(color: Colors.red),
                                  ),
                            child: TextFormField(
                              decoration: _valid_email
                                  ? InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      hintStyle: TextStyle(
                                        color: HexColor('#e58149'),
                                        fontSize: 18,
                                        fontFamily: 'PlutoCondRegular',
                                      ),
                                    )
                                  : InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      hintStyle: TextStyle(
                                        color: HexColor('#e58149'),
                                        fontSize: 18,
                                        fontFamily: 'PlutoCondRegular',
                                      ),
                                      labelText: "invalid email",
                                      labelStyle: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontFamily: 'PlutoCondMedium',
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
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Container(
                            height: 35,
                            padding: EdgeInsets.fromLTRB(15, 16, 0, 0),
                            margin: EdgeInsets.symmetric(
                                horizontal: 42.0, vertical: 2.0),
                            decoration: _valid_password
                                ? BoxDecoration(
                                    color: HexColor('#edeef0'),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  )
                                : BoxDecoration(
                                    color: HexColor('#edeef0'),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    border: Border.all(color: Colors.red)),
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
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
                            )),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(80, 25, 80, 30),
                          // padding: EdgeInsets.only(left:70,right:70),
                          decoration: BoxDecoration(),
                          child: FlatButton(
                            color: HexColor('#72a633'),
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                              email: _email,
                                              password: _password)
                                          .then((currentUser) =>
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login())))
                                          .catchError((error) {
                                        print('Registration Failed!');
                                        showAlertDialog(context, error.code);
                                      })
                                    }
                                }
                            },
                          ))
                    ]))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
