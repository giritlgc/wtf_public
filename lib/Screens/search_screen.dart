import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knowyourfood/Auth.dart';
import 'package:knowyourfood/List.dart';
import 'package:knowyourfood/Screens/additives.dart';
import 'package:knowyourfood/Screens/image_ocrtext.dart';
import 'package:knowyourfood/Screens/logout_alert.dart';
import 'package:knowyourfood/custom_showcasewidget.dart';

import 'package:knowyourfood/CommonComponents/loader.dart';
import 'package:showcaseview/showcase_widget.dart';

import '../CommonComponents/common_widget.dart';
import '../CommonComponents/custom_app_bar.dart';
import 'login.dart';
import 'registration.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  File _image;
  // String _uploadedFileURL;
  String deviceId;

  var loading = 2;

  TextEditingController _textController = new TextEditingController();

  FocusNode _textFocus = new FocusNode();

  AdditiveList additiveList;
  AdditiveNameList additiveNameList;

  bool _valid = true;
  final databaseReference = FirebaseFirestore.instance;
  TextEditingController _emailTextController = new TextEditingController();
  FocusNode _emailTextFocus = new FocusNode();
  bool loggedIn = FirebaseAuth.instance.currentUser != null;
  var suggestions = [];
  bool buffering = false;
  final keyOne = GlobalKey();
  final keyTwo = GlobalKey();
  final keyThree = GlobalKey();
  final keyFour = GlobalKey();

  @override
  void initState() {
    super.initState();
    _getId();

    _controller = AnimationController(vsync: this);

    _textFocus.addListener(onChange);

    _emailTextFocus.addListener(onChangeEmail);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
              backgroundColor: HexColor("#f38343"),
              title: Text(
                "From where do you want to take the photo?",
                style: TextStyle(
                    fontFamily: 'PlutoCondMedium', color: Colors.white),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    RaisedButton(
                      color: HexColor('#76af2c'),
                      child: Text(
                        "Gallery",
                        style: TextStyle(
                            fontFamily: 'PlutoCondMedium', color: Colors.white),
                      ),
                      onPressed: () {
                        _openGallery(context);
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      color: HexColor('#76af2c'),
                      child: Text(
                        "Camera",
                        style: TextStyle(
                            fontFamily: 'PlutoCondMedium', color: Colors.white),
                      ),
                      onPressed: () {
                        _openCamera(context);
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context) async {
    File picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      _image = picture;
    });

    if (_image == null) {
      return;
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ShowCaseWidget(
              builder:
                  Builder(builder: (_) => ShowOCRText(_image, deviceId)))));
    }
  }

  void _openCamera(BuildContext context) async {
    File picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      _image = picture;
    });

    if (_image == null) {
      return;
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ShowOCRText(_image, deviceId)));
    }
  }

  void onChange() {
    String text = _textController.text;
    bool hasFocus = _textFocus.hasFocus;
    if (hasFocus) {
      // FocusScope.of(context).requestFocus(new FocusNode());
      // Navigator.push(context, SlideRightRoute(page:AutoComplete()));
      setState(() {
        getSuggestions(_textController.text.trim());
        loading = 1;
      });
    }
    //do your text transforming
    // if(!hasFocus && text!=""){
    //   print("Redirecting to additive page");
    //   Dio dio = new Dio();
    //   var uploadURL = "http://34.123.192.200:8000/api/search/";

    //   dio.post(uploadURL, data: {"name":text,"deviceId":deviceId}, options: Options(
    //   method: 'POST',
    //   responseType: ResponseType.json // or ResponseType.JSON
    //   ))
    //   .then((response) => {
    //         setState((){
    //           loading = false;
    //         }),
    //         additiveList = AdditiveList.fromJson(jsonDecode(response.toString())),
    //         print(additiveList.ingredients),
    //         if(additiveList.ingredients.length==0){
    //           showAlertDialog(context, "Sorry, no matches found! Please share your email to be updated of new matches as we continuously update & enhance our database.")
    //         }else{
    //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdditivePage(dataList:additiveList.ingredients)))
    //         }
    //   })
    //   .catchError((error) => {
    //     setState((){
    //           loading = false;
    //         }),
    //     print(error),
    //     showAlertDialog(context,"Sorry, no matches found! Please share your email to be updated of new matches as we continuously update & enhance our database.")
    //     });

    // }
    print(text);
  }

  showAlertDialog(BuildContext context, String message) {
    // Create button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(fontFamily: 'PlutoCondRegular'),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        if (!_emailTextFocus.hasFocus &&
            !_valid &&
            _emailTextController.text != "") {
          showAlert(context, "The e-mail entered is invalid");
        }
      },
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(""),
          content: Container(
            height: 200,
            child: ListView(children: [
              Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                          fontFamily: 'PlutoCondMedium',
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextFormField(
                          controller: _emailTextController,
                          focusNode: _emailTextFocus,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Please enter email",
                              hintStyle: TextStyle(
                                color: HexColor('#e58149'),
                                fontSize: 16,
                                fontFamily: 'PlutoCondMedium',
                              ),
                              icon: Icon(Icons.email, color: Colors.black)),
                          onChanged: (text) {
                            setState(() {
                              _valid = validateEmail(text);
                            });
                          },
                        )),
                    RaisedButton(
                        child: Text(
                          "Register",
                          style: TextStyle(
                              fontFamily: 'PlutoCondMedium',
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        textColor: Colors.white,
                        color: HexColor('#e58149'),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ShowCaseWidget(
                                  builder: Builder(
                                      builder: (_) => Registration()))));
                        })
                  ]),
            ]),
          ),
          actions: [
            okButton,
          ],
        );
      },
    );
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  Future<void> onChangeEmail() async {
    String text = _emailTextController.text;
    bool hasFocus = _emailTextFocus.hasFocus;
    //do your text transforming
    if (!hasFocus && _valid && text != "") {
      print(text);
      await databaseReference
          .collection("emailData")
          .add({
            'email': text,
            'deviceId': deviceId,
            'timeStamp': DateTime.now()
          })
          .then((response) {
            showAlert(context,
                "Your email has been recorded. We will keep you posted of relevant updates!");
          })
          .timeout(Duration(seconds: 10))
          .catchError((error) {
            print(error);
          });
      setState(() {
        _emailTextController.text = '';
      });
    }
  }

  void _submit() {
    String text = _textController.text;
    if (text != "") {
      setState(() {
        loading = 0;
      });
      print("Redirecting to additive page");
      Dio dio = new Dio();
      var uploadURL = "http://35.223.112.99:8000/api/search/";
      var userInfo = "null";
      if (loggedIn) {
        userInfo = FirebaseAuth.instance.currentUser.providerData[0].email;
      }
      dio
          .post(uploadURL,
              data: {
                "name": text.trim(),
                "deviceId": deviceId,
                "user": userInfo
              },
              options: Options(
                  method: 'POST',
                  responseType: ResponseType.json // or ResponseType.JSON
                  ))
          .then((response) => {
                setState(() {
                  loading = 2;
                }),
                additiveList =
                    AdditiveList.fromJson(jsonDecode(response.toString())),
                print(additiveList.ingredients),
                if (additiveList.ingredients.length == 0)
                  {
                    showAlertDialog(context,
                        "Sorry, no matches found! Please share your email to be updated of new matches as we continuously update & enhance our database.")
                  }
                else
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShowCaseWidget(
                            builder: Builder(
                                builder: (_) => AdditivePage(
                                    dataList: additiveList.ingredients)))))
                  }
              })
          .catchError((error) => {
                setState(() {
                  loading = 2;
                }),
                print(error),
                showAlertDialog(context,
                    "Sorry, no matches found! Please share your email to be updated of new matches as we continuously update & enhance our database.")
              });
    } else {
      showAlert(context,
          "Please try searching again and pick one of the additive names shown.");
    }
  }

  decisionAlertDialog(BuildContext context) {
    // set up the button
    Widget yes = RaisedButton(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
        child: Text(
          "Yes",
          style: TextStyle(fontFamily: 'PlutoCondRegular', color: Colors.white),
        ),
      ),
      color: HexColor('#76af2c'),
      onPressed: () {
        signOutUser().whenComplete(() => {
              Navigator.of(context).pop(),
              setState(() {
                loggedIn = false;
                showAlert(context, "You have been logged out");
              })
            });
      },
    );

    Widget no = Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 15, 0),
        child: RaisedButton(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
            child: Text(
              "No",
              style: TextStyle(
                  fontFamily: 'PlutoCondRegular', color: Colors.white),
            ),
          ),
          color: HexColor("#ecd343"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ));
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: RichText(
          text: TextSpan(
              style: TextStyle(
                  fontFamily: 'PlutoCondRegular',
                  fontSize: 16,
                  color: Colors.white),
              children: <TextSpan>[
            TextSpan(text: 'Do you want to '),
            TextSpan(
                text: "logout?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ])),
      backgroundColor: HexColor("#f38343"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      actions: [yes, no],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // ignore: missing_return
  void getSuggestions(String pattern) async {
    if (pattern != "") {
      setState(() {
        buffering = true;
      });
      Dio dio = new Dio();
      var uploadURL = "http://35.223.112.99:8000/api/additiveNameSuggestions/";

      await dio
          .post(uploadURL,
              data: {"name": pattern.trim(), "deviceId": deviceId},
              options: Options(
                  method: 'POST',
                  responseType: ResponseType.json // or ResponseType.JSON
                  ))
          .then((response) => {
                print(response),
                if (pattern != _textController.text)
                  {getSuggestions(_textController.text)},
                additiveNameList =
                    AdditiveNameList.fromJson(jsonDecode(response.toString())),
                print(additiveNameList.additiveNames),
                if (additiveNameList.additiveNames.length != 0)
                  {
                    setState(() {
                      buffering = false;
                      suggestions = additiveNameList.additiveNames;
                    })
                  }
                else
                  {
                    setState(() {
                      buffering = false;
                      suggestions = ["No additives found!"];
                    })
                  }
              })
          .catchError((error) => {
                print(error),
              });
    } else {
      setState(() {
        suggestions = [];
      });
    }
  }

  List<Widget> buildList(dataList) {
    var row;
    List<Widget> list = [];
    var f = 0;
    for (var i = 0; i < dataList.length; i++) {
      if (f == 0) {
        row = GestureDetector(
          onTap: () {
            setState(() {
              loading = 2;
              _textController.text = dataList[i];
            });
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
            color: HexColor('#eff7f9'),
            child: Text(
              dataList[i],
              style: TextStyle(
                fontSize: 16,
                color: HexColor('#635950'),
                fontFamily: 'PlutoCondMedium',
              ),
            ),
          ),
        );
        f = 1;
      } else {
        row = GestureDetector(
            onTap: () {
              setState(() {
                loading = 2;
                _textController.text = dataList[i];
              });
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
              color: HexColor('#dbeaef'),
              child: Text(
                dataList[i],
                style: TextStyle(
                  fontSize: 16,
                  color: HexColor('#635950'),
                  fontFamily: 'PlutoCondMedium',
                ),
              ),
            ));
        f = 0;
      }
      list.add(row);
    }
    if (dataList.length == 1 && dataList[0] == "No additives found!") {
      return [
        Container(
          padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
          color: HexColor('#eff7f9'),
          child: Text(
            "No additives found!",
            style: TextStyle(
              fontSize: 16,
              color: HexColor('#635950'),
              fontFamily: 'PlutoCondMedium',
            ),
          ),
        )
      ];
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    switch (loading) {
      case 0:
        return Loading();
        break;
      case 1:
        return Material(
            child: Column(children: [
          Material(
            elevation: 20.0,
            shadowColor: HexColor('#5ca4b8'),
            child: Container(
                padding: EdgeInsets.only(top: 30),
                color: HexColor('#5ca4b8'),
                height: 80,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: HexColor('#716663')),
                    // iconSize: 30,
                    onPressed: () => {
                      setState(() {
                        loading = 2;
                      })
                    },
                  ),
                  SizedBox(
                      width: 240,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.0))),
                        child: TextFormField(
                          autofocus: true,
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: "Search for an additive",
                            hintStyle: TextStyle(
                              color: HexColor('#716663'),
                              fontSize: 18,
                              fontFamily: 'PlutoCondRegular',
                            ),
                            suffixIcon: _textController.text.length > 0
                                ? IconButton(
                                    icon: Icon(Icons.cancel_outlined,
                                        color: HexColor('#716663')),
                                    onPressed: () {
                                      setState(() {
                                        _textController.text = "";
                                        suggestions = [];
                                      });
                                    },
                                  )
                                : null,
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            getSuggestions(value.trim());
                          },
                        ),
                      ))
                ])),
          ),
          buffering
              ? Container(color: HexColor('#ebf3e3'), child: Buffering())
              : Expanded(
                  child: ListView(
                  padding: EdgeInsets.all(0.0),
                  children: buildList(suggestions),
                )),
        ]));
        break;
      default:
        return Scaffold(
            appBar: CustomAppBar4("What the Food?"),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/foodBackground2.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    loggedIn
                        ? Container(
                            padding: EdgeInsets.only(top: 30),
                            child: RaisedButton(
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                    fontFamily: 'PlutoCondRegular',
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                              color: HexColor("#f18447"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(10.0),
                                bottomLeft: const Radius.circular(10.0),
                              )),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LogoutAlert()));
                              },
                            ))
                        : Container(
                            padding: EdgeInsets.only(top: 30),
                            child: CustomShowcaseWidget(
                              description: "User Authentication.",
                              globalKey: keyFour,
                              child: RaisedButton(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontFamily: 'PlutoCondRegular',
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                                color: HexColor("#5ca4b8"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(10.0),
                                  bottomLeft: const Radius.circular(10.0),
                                )),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ShowCaseWidget(
                                          builder: Builder(
                                              builder: (_) => Login()))));
                                },
                              ),
                            )),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 60.0),
                  margin: EdgeInsets.fromLTRB(15.0, 30, 15, 10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: Column(
                    children: [
                      Container(
                        height: 38,
                        margin: EdgeInsets.symmetric(
                            horizontal: 35.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.4),
                          border: Border.all(color: HexColor('#5ca4b8')),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(9, 9, 0, 9),
                              child: Image.asset(
                                'images/loupe.png',
                                width: 30,
                                height: 30,
                                fit: BoxFit.contain,
                                color: HexColor('#716663'),
                              ),
                            ),
                            CustomShowcaseWidget(
                              description: 'Type additive name here',
                              globalKey: keyOne,
                              child: Container(
                                  child: SizedBox(
                                width: 160,
                                child: TextFormField(
                                  controller: _textController,
                                  focusNode: _textFocus,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(0, 1, 0, 8),
                                    border: InputBorder.none,
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                      color: HexColor('#e58149'),
                                      fontSize: 18,
                                      fontFamily: 'PlutoCondRegular',
                                    ),
                                  ),
                                ),
                              )),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 15),
                                child: InkWell(
                                  onTap: () {
                                    _showSelectionDialog(context);
                                  },
                                  child: CustomShowcaseWidget(
                                    description:
                                        "Upload or take a pictute of product label",
                                    globalKey: keyThree,
                                    child: Image.asset('images/camera.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                        color: HexColor('#435839')),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(80, 150, 80, 50),
                          // padding: EdgeInsets.only(left:70,right:70),
                          decoration: BoxDecoration(),
                          child: CustomShowcaseWidget(
                              description:
                                  "Click submit after typing additive name",
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
                                    ),
                                  ],
                                ),
                                onPressed: () => {_submit()},
                              )))
                    ],
                  ),
                ),
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
                                color: HexColor("#f38343"), width: 5)),
                      ),
                    ],
                  ),
                )
              ]),
            ));
    }
  }

  void _getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    deviceId = androidDeviceInfo.androidId; // unique ID on Android
  }
}
