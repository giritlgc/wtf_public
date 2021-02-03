import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:knowyourfood/Auth.dart';
import 'package:knowyourfood/changePassword.dart';
import 'package:knowyourfood/registration.dart';
import 'package:knowyourfood/search_page.dart';

import 'common_widget.dart';

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

  String username ;
  String password ;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ListView(
          children:[
            Container(
          color: HexColor('#e9ce3f'),
          child: Column(children: [
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
                  children:[ 
                    Container(
          margin: EdgeInsets.fromLTRB(15, 35, 15, 130),
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
                              decoration: valid_username ? BoxDecoration(
                                color: HexColor('#edeef0'),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(12.0)),
                              ):
                              BoxDecoration(
                                color: HexColor('#edeef0'),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(12.0)),
                                border: Border.all(color: Colors.red),
                              ),
                              child: SizedBox(
                                  width: 175,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(8,0,0,15),
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
                          ])),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                              decoration: valid_password ? BoxDecoration(
                                color: HexColor('#edeef0'),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(12.0)),
                              ):
                              BoxDecoration(
                                color: HexColor('#edeef0'),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(12.0)),
                                border: Border.all(color: Colors.red),
                              ),
                              child: SizedBox(
                                  width: 175,
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(8,0,0,15),
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
                          ])),
                  Container(
                      margin: EdgeInsets.fromLTRB(80, 50, 80, 20),
                      // padding: EdgeInsets.only(left:70,right:70),
                      decoration: BoxDecoration(),
                      child: FlatButton(
                        color: HexColor('#72a633'),
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
                        onPressed: () =>
                            {
                              if (_formKey.currentState.validate()) {
                                if(username.isNotEmpty && password.isNotEmpty){
                                  FirebaseAuth.instance.signInWithEmailAndPassword(email: username.trim(), password: password.trim())
                                  .then((user) =>  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                                    SearchPage()), (Route<dynamic> route) => false),)
                                  .catchError((error){
                                    print('Login Failed!');
                                    if (error.code == 'user-not-found'){
                                      showAlert(context, "Sorry, we could not find a user with email ");
                                    }else if(error.code == 'wrong-password'){
                                      showAlert(context, "Sorry, that's not the right password");
                                    }else{
                                      showAlert(context, error.code);
                                    }
                                    
                                  })  
                                }
                              }
                            },
                      )),
                  MaterialButton(
                    padding: EdgeInsets.only(bottom:20),
                    onPressed: () => googleSignIn().then((value) async {
                      
                        if (value) {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                                      SearchPage()), (Route<dynamic> route) => false);
                        }
                    }),
                    child: Image(
                      image: AssetImage('images/googleSignIn.png'),
                      width: 200.0,
                    ),
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
                  Container(
                    child: InkWell(
                      child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PlutoCondRegular',
                        color: HexColor('#cfc8c5'),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePassword()));
                    },
                    ) 
                    
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 40),
                    child: InkWell(
                      child:Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PlutoCondRegular',
                        color: HexColor('#cfc8c5'),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Registration()));
                    },
                    )                         
                  )
                ],
              ))),
              Positioned.fill(
                child:Align(
                  alignment: Alignment(0,0.78),
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
              )],
            )
          ]),
        ),
        ]));
         
      
    
  }
}
