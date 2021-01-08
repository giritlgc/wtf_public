import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  
  // ignore: non_constant_identifier_names
  bool _valid_email = true;
  String _email;
  TextEditingController _textController = new TextEditingController();

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
          title: Text("Reset Password!"),
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
        child: ListView(children:[Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 28),
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
                    padding: EdgeInsets.fromLTRB(0, 62, 0, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Trouble Logging In?",
                            style: TextStyle(
                              color: HexColor('#72a633'),
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
                              color: HexColor('#72a633'),
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
                              color: HexColor('#72a633'),
                              fontSize: 16,
                              fontFamily: 'PlutoCondRegular',
                            ),
                          ),
                        ])),
                Padding(
                  padding: EdgeInsets.only(top: 32),
                  child: Container(
                      height: 35,
                      margin:
                          EdgeInsets.symmetric(horizontal: 42.0, vertical: 2.0),
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
                        controller: _textController,
                        decoration:InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(15,0,0,10),
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
                      )),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(80, 32, 80, 50),
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
                        if(_email == null){
                          setState(() {
                              _valid_email = false;
                            })
                        },
                        if (_email.isNotEmpty && validateEmail(_email))
                          {
                            FirebaseAuth.instance
                                .sendPasswordResetEmail(email: _email).then((value) => {
                                  showAlertDialog(context, "Email sent successfully."),
                                  setState(() {
                                    _email = '';
                                    _valid_email = true;
                                    _textController.text = '';
                                  })
                                }).catchError((error){
                                  showAlertDialog(context, error.code);
                                })
                          }
                        else
                          {
                            setState(() {
                              _valid_email = false;
                            })
                          }
                      },
                    ))
              ],
            ),
          )
        ]),])
      ),
    );
  }
}
