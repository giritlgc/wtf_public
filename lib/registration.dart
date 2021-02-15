import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:knowyourfood/Auth.dart';
import 'package:knowyourfood/login.dart';
import 'package:knowyourfood/search_page.dart';

import 'common_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: HexColor('#e9ce3f'),
        child: SingleChildScrollView(child:Column(children: [
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
          Stack(
                      children:[ Container(
              margin: EdgeInsets.fromLTRB(15, 35, 15, 130),
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
                                  contentPadding: EdgeInsets.fromLTRB(15,0,0,10),
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
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Container(
                              height: 35,
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
                                  contentPadding: EdgeInsets.fromLTRB(15,0,0,10),
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
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Container(
                              height: 35,
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
                                decoration: InputDecoration(
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
                                  contentPadding: EdgeInsets.fromLTRB(15,0,0,10),
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
                                                email: _email.trim(),
                                                password: _password.trim())
                                            .then((currentUser) async =>{
                                              await currentUser.user.updateProfile(displayName: _firstname +" "+ _surname), 
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()))})
                                            .catchError((error) {
                                          print('Registration Failed!');
                                          if(error.code == 'email-already-in-use'){
                                            showAlert(context, "An account with this email already exists");
                                          }else if(error.code == "Invalid-email"){
                                            showAlert(context, "The e-mail entered is invalid");
                                          }else if(error.code == "weak-password"){
                                            showAlert(context, "This password is not valid");
                                          }else{
                                            showAlert(context, error.code);
                                          }
                                        })
                                      }
                                  }
                              },
                            )),
                            SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom,
                        ),
            MaterialButton(
                      padding: EdgeInsets.only(bottom:20),
                      onPressed: () => googleSignIn().then((value) async {
                        
                          if (value) {
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                                        SearchPage()), (Route<dynamic> route) => false);
                          }
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          border:Border.all(color: Colors.black, width: 1)
                        ),
                        child: Image(
                          image: AssetImage('images/googleSignUp.png'),
                          width: 200.0,
                          height: 40,
                        ),
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
                    padding: EdgeInsets.only(bottom: 40),
                    child: InkWell(
                      child:Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PlutoCondRegular',
                        color: HexColor('#cfc8c5'),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                    },
                    )                         
                  )
                              
                      ]))
                ],
              ),
            ),
            Positioned.fill(
                child:Align(
                  alignment: Alignment(0,0.82),
        child:Container(
          decoration: BoxDecoration(
            color: HexColor('#e58149'),
            borderRadius: BorderRadius.all(Radius.circular(100))
          ),
          padding: EdgeInsets.all(17),
           child:Image.asset(            
                            'images/grocery_bag.png',
                            width: 65,
                            height: 65,                      
                        ),
        ))
            )]
          )
          ]))
      ),
    );
  }
}
