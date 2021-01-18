import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knowyourfood/List.dart';
import 'package:knowyourfood/additives.dart';
import 'package:knowyourfood/image_ocrtext.dart';
import 'package:knowyourfood/loader.dart';
import 'package:knowyourfood/registration.dart';

import 'custom_app_bar.dart';
import 'login.dart';


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
    RecognisedText ocrText;
  
    bool _valid = true;
    final databaseReference = FirebaseFirestore.instance;
    TextEditingController _emailTextController = new TextEditingController();
    FocusNode _emailTextFocus = new FocusNode();
  bool loggedIn = FirebaseAuth.instance.currentUser != null;
  var suggestions = [];
  bool buffering = false;

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
                title: Text("From where do you want to take the photo?",
                style: TextStyle(
                  fontFamily: 'PlutoCondMedium',
                ),),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      GestureDetector(
                        child: Text("Gallery",
                        style: TextStyle(
                        fontFamily: 'PlutoCondMedium',
                      ),
                ),
                        onTap: () {
                          _openGallery(context);
                          Navigator.pop(context);
                        },
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      GestureDetector(
                        child: Text("Camera",
                        style: TextStyle(
                        fontFamily: 'PlutoCondMedium'
                      ),),
                        onTap: () {
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
  
      if(_image==null){
        return;
      }else{
         Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowOCRText(_image,deviceId)));
      }
    
    }
  
  void _openCamera(BuildContext context) async {
    
      File picture = await ImagePicker.pickImage(source: ImageSource.camera);
      this.setState(() {
        _image = picture;
      });
  
      if(_image==null){
        return;
      }else{
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowOCRText(_image,deviceId)));
      }
      
    }
  
  
  void onChange(){
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
      title: Text(""),  
      content: Column (
        mainAxisSize: MainAxisSize.min,
        children:[
          Text(message,
          style: TextStyle(
            fontFamily:'PlutoCondMedium',
            fontWeight: FontWeight.bold
          ),
          ),
          Container(
                margin: EdgeInsets.symmetric(horizontal:2.0,vertical:2.0),
                decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius:BorderRadius.all(Radius.circular(20.0)),
               
  
                ),
                child:TextFormField(
                  controller: _emailTextController,
                  focusNode: _emailTextFocus,
                  decoration:InputDecoration(
                    border: InputBorder.none,
                     hintText:"Please enter email",
                     hintStyle: TextStyle(
                       color: HexColor('#e58149'),
                       fontSize: 16,
                       fontFamily: 'PlutoCondMedium',
                     ),
                     icon: Icon(Icons.email,color: Colors.black)
  
                  ),
                  onChanged: (text){
                    setState(() {
                      _valid = validateEmail(text);
                    });
    
                  },
                )
              ),
          RaisedButton(
            child: Text("Register",
              style: TextStyle(
                fontFamily:'PlutoCondMedium',
                fontWeight: FontWeight.bold,
                 fontSize: 16
              ),
            ), 
            textColor: Colors.white,
            color:  HexColor('#e58149'),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Registration()));
            }
            )
          ]
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
      if(!hasFocus && _valid && text!=""){
        print(text);
        await databaseReference.collection("emailData")
          .add({
            'email':text,
            'deviceId':deviceId,
            'timeStamp': DateTime.now()
          }).then((response) {
        showAlertDialogEmail(context, "Successfully submitted");
      }).timeout(Duration(seconds:10)).catchError((error) {
        print(error);
      });
      setState(() {
         _emailTextController.text = '';  
      });
       
      }else if(!hasFocus && !_valid){
        showAlertDialogEmail(context, "Invalid Email");
      }
    }
  
   showAlertDialogEmail(BuildContext context, String message) {  
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
      title: Text("Email"),  
      content: Text(message,
      style: TextStyle(
        fontFamily: 'PlutoCondRegular'
      ),
      ),  
      actions: [  
        okButton,  
      ],  
    );  
      },  
    );  
  }  
  
  void _submit(){    
    String text = _textController.text;
    if(text!=""){
       setState(() {
        loading = 0;
      });
      print("Redirecting to additive page");
      Dio dio = new Dio();
      var uploadURL = "http://34.123.192.200:8000/api/search/";
  
      dio.post(uploadURL, data: {"name":text.trim(),"deviceId":deviceId}, options: Options(
      method: 'POST',
      responseType: ResponseType.json // or ResponseType.JSON
      ))
      .then((response) => {
            setState((){
                  loading = 2;
            }),
            additiveList = AdditiveList.fromJson(jsonDecode(response.toString())),
            print(additiveList.ingredients),
            if(additiveList.ingredients.length==0){
              showAlertDialog(context, "Sorry, no matches found! Please share your email to be updated of new matches as we continuously update & enhance our database.") 
            }else{
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdditivePage(dataList:additiveList.ingredients)))
            }
      })
      .catchError((error) => {
        setState((){
                  loading = 2;
            }),
        print(error),
        showAlertDialog(context,"Sorry, no matches found! Please share your email to be updated of new matches as we continuously update & enhance our database.")
        });
  
    
  
    }
  }
  
  
decisionAlertDialog(BuildContext context) {

  // set up the button
  Widget yes = FlatButton(
    child: Text("Yes"),
    onPressed: () { 
      
      FirebaseAuth.instance.signOut().then((value) => {
        Navigator.of(context).pop(),
        setState(() {
          loggedIn = false;
        })
      });
    },
  );

   Widget no = FlatButton(
    child: Text("No"),
    onPressed: () { 
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Logout!"),
    content: Text("Do you want to logout?"),
    actions: [
      yes,
      no
    ],
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
    if(pattern!=""){
      setState(() {
        buffering = true;
      });
      Dio dio = new Dio();
      var uploadURL = "http://34.123.192.200:8000/api/additiveNameSuggestions/";
     
      await  dio.post(uploadURL, data: {"name":pattern.trim(),"deviceId":deviceId}, options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
            ))
            .then((response) => {
                  print(response),
                  additiveNameList = AdditiveNameList.fromJson(jsonDecode(response.toString())),
                  print(additiveNameList.additiveNames),
                if(additiveNameList.additiveNames.length!=0){
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
    }else{
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
             onTap: (){
            setState(() {
                          loading = 2;
                           _textController.text = dataList[i];
                        });
          } ,
              child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
          color: HexColor('#ebf3e3'),
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
             onTap: (){
            setState(() {
                          loading = 2;
                           _textController.text = dataList[i];
                        });
          } ,
              child:Container(
        padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
        color: HexColor('#d1e0bc'),
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
          shadowColor:HexColor('#72a633'),
                      child: Container(
                padding: EdgeInsets.only(top: 30),
                color: HexColor('#72a633'),
                height: 80,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                          padding: EdgeInsets.only(left:10),
                          margin: EdgeInsets.symmetric(horizontal:4,vertical:2),
                          color:  HexColor('#72a633'),
                          foregroundDecoration: BoxDecoration(
                            color:Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.all(Radius.circular(18.0))
                            
                          ),
                          child: TextFormField(
                            autofocus: true,
                            controller: _textController,
                            decoration: InputDecoration(
                              focusColor: Colors.red,
                              hintText: "Search for a additive",
                              hintStyle: TextStyle(
                                color: HexColor('#716663'),
                                fontSize: 18,
                                fontFamily: 'PlutoCondRegular',
                              ),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              getSuggestions(value.trim());
                            },
                          ),
                        )
                      )
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
            appBar: CustomAppBar("Know Your Food"),
            body: ListView(children: [
              loggedIn
                  ? InkWell(
                      child: Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 40.0,
                ),
                      onTap: () {
                  decisionAlertDialog(context);
                },
                    )
                  : InkWell(
                      child: Icon(
                  Icons.login,
                  color: Colors.black,
                  size: 40.0,
                ),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login()));
                },
              ),
          Container(
                padding: EdgeInsets.only(top: 60.0),
                margin: EdgeInsets.fromLTRB(15.0, 50, 15, 90),
          decoration: BoxDecoration(
             color: HexColor('#d1e0bc'),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
          child: Column(
            children: [
              Container(
                      height: 38,
                      margin:
                          EdgeInsets.symmetric(horizontal: 35.0, vertical: 2.0),
                    decoration: BoxDecoration(
                    color: Colors.white,
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
                  Container(
                    child: SizedBox(
                      width: 160,
                            child: TextFormField(
                            controller: _textController,
                              focusNode: _textFocus,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(0, 1, 0, 8),
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
                   Container(
                              padding: EdgeInsets.only(right: 15),
                         child: InkWell(
                         onTap: () {
                           _showSelectionDialog(context);
                         },
                                child: Image.asset('images/camera.png',
                            width: 30,
                            height: 30,            
                            fit: BoxFit.cover,
                                    color: HexColor('#435839')),
                              )),
                ],
              ),
              ),             
              Container(
                        margin: EdgeInsets.fromLTRB(80, 150, 80, 50),
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
                          onPressed: () => {_submit()},
                        ))
            ],
          ),
        )
            ]));
    }
    }
  
  void _getId() async {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
     
        AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    deviceId = androidDeviceInfo.androidId; // unique ID on Android
  }
    }
