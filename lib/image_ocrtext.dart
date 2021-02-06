import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:knowyourfood/registration.dart';

import 'List.dart';
import 'additives.dart';
import 'common_widget.dart';
import 'custom_app_bar.dart';
import 'loader.dart';

class ShowOCRText extends StatefulWidget {
  ShowOCRText(this._image,this.deviceId);
  final File _image;
  final String deviceId;

  @override
  _ShowOCRTextState createState() => _ShowOCRTextState();
}

class _ShowOCRTextState extends State<ShowOCRText> {

  bool _isEditingText = false;
  TextEditingController _editingController;
  String initialText;
  AdditiveNameList additiveNameList;
  
  bool loading = false;
  RecognisedText ocrText;
  bool buffering = true;
  Error errorMessage;
  bool loggedIn = FirebaseAuth.instance.currentUser != null;

  TextEditingController _emailTextController = new TextEditingController();
  FocusNode _emailTextFocus = new FocusNode();
  bool _valid = true;
  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getRecognisedText(widget._image);
    initialText = '';
    _editingController = TextEditingController(text: initialText);
    _emailTextFocus.addListener(onChangeEmail);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  void  getRecognisedText(_image) async {
    Dio dio = new Dio();
    var uploadURL = "http://34.123.192.200:8000/api/getRecognisedText/";
    String fileName = _image.path.split('/').last;
    var userInfo = "null";
    if(loggedIn){
      userInfo = FirebaseAuth.instance.currentUser.providerData[0].email;
    }
    FormData formdata = new FormData.fromMap({
          "image":
              await MultipartFile.fromFile(_image.path, filename:fileName),
          "deviceId":widget.deviceId,
          "user":userInfo    
      });
      
        dio.post(uploadURL, data: formdata, options: Options(
        method: 'POST',
        responseType: ResponseType.json // or ResponseType.JSON
        ))
        .then((response) => {  
          ocrText = RecognisedText.fromJson(jsonDecode(response.toString())),
          setState((){
            buffering = false;
            initialText = ocrText.recognisedText;
            _editingController.text = ocrText.recognisedText;
          })
    })
    .catchError((error) => {
      errorMessage = Error.fromJson(jsonDecode(error.response.toString())),
      setState((){
        buffering = false;
      }),
      showAlert(context,errorMessage.message)
      });
  }

  Widget _editTitleTextField() {
  if (_isEditingText)
    return Center(
      child: TextField(
        maxLines: 10,
        decoration: InputDecoration(
          border: InputBorder.none
        ),
        onChanged: (newValue){
          setState(() {
            initialText = _editingController.text;
          });
        },
        autofocus: true,
        controller: _editingController,
      ),
    );
  return InkWell(
    onTap: () {
      setState(() {
        _isEditingText = true;
      });
    },
    child: Text(
  initialText,
  style: TextStyle(
    color: Colors.black,
    fontSize: 18.0,
  ),
 )
 );
  }


  void _submit(){    
    String text = initialText;
    if(text!=""){
       setState(() {
      loading = true;
      });
      Dio dio = new Dio();
      var uploadURL = "http://34.123.192.200:8000/api/getAdditiveNames/";
      var userInfo = "null";
      if(loggedIn){
        userInfo = FirebaseAuth.instance.currentUser.providerData[0].email;
      }
      dio.post(uploadURL, data: {"name":text.trim(),"deviceId":widget.deviceId,"user": userInfo}, options: Options(
      method: 'POST',
      responseType: ResponseType.json // or ResponseType.JSON
      ))
      .then((response) => {
            setState((){
              loading = false; 
            }),
            additiveNameList = AdditiveNameList.fromJson(jsonDecode(response.toString())),
            print(additiveNameList.additiveNames),
            if(additiveNameList.additiveNames.length==0){
              showAlertDialog(context, "Sorry, no matches found! Please share your email to be updated of new matches as we continuously update & enhance our database.") 
            }else{
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdditivePage(dataList:additiveNameList.additiveNames)))
            }
      })
      .catchError((error) => {
        setState((){
              loading = false; 
            }),
        print(error),
        showAlertDialog(context,"Sorry, no matches found! Please share your email to be updated of new matches as we continuously update & enhance our database.")
        });
  
    
  
    }
  }

 

  showAlertDialog(BuildContext context, String message) {  
    // Create button  
    Widget okButton = FlatButton(  
      child: Text("OK",
      style: TextStyle(
        fontFamily: 'PlutoCondRegular'
      ),
      ),  
      onPressed: () {  
        Navigator.of(context).pop(); 
        if(!_emailTextFocus.hasFocus && !_valid && _emailTextController.text!=""){
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
              child: ListView(
                children: [Column (
            // mainAxisSize: MainAxisSize.min,
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
            ),]
        ),
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
            'deviceId':widget.deviceId,
            'timeStamp': DateTime.now()
          }).then((response) {
        showAlert(context, "Your email has been recorded. We will keep you posted of relevant updates!");
      }).timeout(Duration(seconds:10)).catchError((error) {
        print(error);
      });
      setState(() {
         _emailTextController.text = '';  
      });
       
      }
    }



  @override
  Widget build(BuildContext context) {
    return  loading? Loading(): _isEditingText ? Material(
            child: Column(children: [
          Material(
            elevation: 20.0,
          shadowColor:HexColor('#72a633'),
                      child: Container(
                padding: EdgeInsets.fromLTRB(40, 30, 0 ,0 ),
                color: HexColor('#72a633'),
                height: 80,
                child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child:Text(
                          "Edit text",
                          style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ColbyCompressed' ,
                          color: Colors.white
                          )
                        )
                      )
                    ])),
        ),
        Padding(
          padding: EdgeInsets.only(top:10),
                  child: Stack(
            children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                decoration: BoxDecoration(
                    border: Border.all(color: HexColor('#d1e0bc'), width: 5),
                    
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Column(
                  children:[
                    Row(),
                    _editTitleTextField()
                  ]
                )),
            Align(
              alignment: Alignment(0.95,0),
              child:_isEditingText? Container(
                 decoration: BoxDecoration(
                    color: HexColor('#f0dc47'),
                    borderRadius: BorderRadius.all(Radius.circular(100))
                  ),
                
                child:IconButton(
                icon:Icon(Icons.check),
                iconSize: 30,
                color: HexColor("#80721d"),
                onPressed: (){
                  setState(() {
                    _isEditingText = false;
                  });
                },
                )):
                 Container(
                 decoration: BoxDecoration(
                    color: HexColor('#f0dc47'),
                    borderRadius: BorderRadius.all(Radius.circular(100))
                  ),
                
                child:IconButton(
                icon:Icon(Icons.edit),
                iconSize: 30,
                color: HexColor("#80721d"),
                onPressed: (){
                  setState(() {
                    _isEditingText = true;
                  });
                },
                ))
            )
            ]),
        )
        ]))

    :Scaffold(
        appBar: CustomAppBar2("Know Your Food"),
        body: ListView(children:[
          Container(
                margin: EdgeInsets.fromLTRB(15.0, 50, 15, 90),
          decoration: BoxDecoration(
            //  color: HexColor('#d1e0bc'),
                    border: Border.all(color: HexColor('#d1e0bc'),width: 5),
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
          child:
          Column(
          children: [
          Container(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
                  child: Text("Image",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'PlutoCondMedium',
                  ),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: HexColor('#72a633'),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(35.0),
                topRight: const Radius.circular(35.0),
              )
            ),
          ),  
          Container(
            // padding: EdgeInsets.only(top:60),
            margin: EdgeInsets.fromLTRB(15.0, 20, 15, 20),
            child: Image.file(widget._image),
          ),
          Container(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
                  child: Text("Recognised Text",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'PlutoCondMedium',
                  ),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: HexColor('#72a633'),
            ),
          ),  
          buffering?Container(color: Colors.white,child: Buffering()):Stack(
          children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              padding: EdgeInsets.fromLTRB(10,10,10,10),
              decoration: BoxDecoration(
                  border: Border.all(color: HexColor('#d1e0bc'), width: 5),
                  
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Column(
                children:[
                  Row(),
                  _editTitleTextField()
                ]
              )),
          Positioned.fill(
              child: Align(
              alignment: Alignment(0.95,1),
              child:_isEditingText? Container(
                 decoration: BoxDecoration(
                    color: HexColor('#f0dc47'),
                    borderRadius: BorderRadius.all(Radius.circular(100))
                  ),
                
                child:Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: IconButton(
                  icon:Icon(Icons.check),
                  iconSize: 30,
                  color: HexColor("#80721d"),
                  onPressed: (){
                    setState(() {
                      _isEditingText = false;
                    });
                  },
                  ),
                )):
                 Container(
                 decoration: BoxDecoration(
                    color: HexColor('#f0dc47'),
                    borderRadius: BorderRadius.all(Radius.circular(100))
                  ),
                
                child:IconButton(
                icon:Icon(Icons.edit),
                iconSize: 30,
                color: HexColor("#80721d"),
                onPressed: (){
                  setState(() {
                    _isEditingText = true;
                  });
                },
                ))
            ),
          )
          ]),
          Container(
                margin: EdgeInsets.fromLTRB(80,30,80,50),
                // padding: EdgeInsets.only(left:70,right:70),
                decoration: BoxDecoration(),
                child:FlatButton(
                   color: HexColor('#72a633'),
                   padding:EdgeInsets.fromLTRB(0,10,0,10) ,
                   shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center ,
                     children: [

                       Container(
                         child: Text('Submit',
                         style: TextStyle(
                           fontSize: 20,
                           fontFamily: 'PlutoCondMedium',
                           color: Colors.white,
                         ),
                         ),
                       )
                     ],
                   ),
                  onPressed:() =>{
                      print(initialText),
                      _submit(),

                  },  
                )
              )
        ]))]));
  }
}
