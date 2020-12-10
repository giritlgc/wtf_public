import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knowyourfood/AdditiveList.dart';
import 'package:knowyourfood/additives.dart';
import 'package:knowyourfood/loader.dart';

import 'custom_app_bar.dart';


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

    bool loading = false;
  
    TextEditingController _textController = new TextEditingController();
  
    FocusNode _textFocus = new FocusNode();
  
    AdditiveList additiveList;
  
    bool _valid = true;
    final databaseReference = FirebaseFirestore.instance;
    TextEditingController _emailTextController = new TextEditingController();
    FocusNode _emailTextFocus = new FocusNode();
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
                  fontFamily: 'Calibri',
                  fontWeight: FontWeight.bold
                ),),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      GestureDetector(
                        child: Text("Gallery",
                        style: TextStyle(
                        fontFamily: 'Calibri',
                        fontWeight: FontWeight.bold
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
                        fontFamily: 'Calibri',
                        fontWeight: FontWeight.bold
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
      }
    setState(() {
      loading = true;
    });
  
  
    Dio dio = new Dio();
    var uploadURL = "http://34.123.192.200:8000/api/image/";
    String fileName = _image.path.split('/').last;
    FormData formdata = new FormData.fromMap({
          "image":
              await MultipartFile.fromFile(_image.path, filename:fileName),
          "deviceId":deviceId    
      });
    dio.post(uploadURL, data: formdata, options: Options(
    method: 'POST',
    responseType: ResponseType.json // or ResponseType.JSON
    ))
    .then((response) => {
          setState((){
            loading = false; 
          }),
          additiveList = AdditiveList.fromJson(jsonDecode(response.toString())),
          print(additiveList.ingredients),
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdditivePage(dataList:additiveList.ingredients)))
  
    })
    .catchError((error) => {
      setState((){
            loading = false; 
          }),
      print(error),
      showAlertDialog(context,"Sorry, no matches found! Please share your email to be updated of new matches as we continuously update & enhance our database.")
      });
    
    }
  
  void _openCamera(BuildContext context) async {
    
      File picture = await ImagePicker.pickImage(source: ImageSource.camera);
      this.setState(() {
        _image = picture;
      });
  
      if(_image==null){
        return;
      }
    setState(() {
      loading = true;
    });
  
       Dio dio = new Dio();
    var uploadURL = "http://34.123.192.200:8000/api/image/";
    String fileName = _image.path.split('/').last;
    FormData formdata = new FormData.fromMap({
          "image":
              await MultipartFile.fromFile(_image.path, filename:fileName),
          "deviceId":deviceId 
      });
    dio.post(uploadURL, data: formdata, options: Options(
    method: 'POST',
    responseType: ResponseType.json // or ResponseType.JSON
    ))
    .then((response) => {
      setState(() {
      loading = false;
    }),
          additiveList = AdditiveList.fromJson(jsonDecode(response.toString())),
          print(additiveList.ingredients),
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdditivePage(dataList:additiveList.ingredients)))
    })
    .catchError((error) => {
       setState(() {
      loading = false;
      }),
      print(error),
      showAlertDialog(context,"Sorry, no matches found! Please share your email to be updated of new matches as we continuously update & enhance our database.")
      });
      
    }
  
  
  void onChange(){
    String text = _textController.text;
    bool hasFocus = _textFocus.hasFocus;
    //do your text transforming
    if(!hasFocus && text!=""){
      print("Redirecting to additive page");
      Dio dio = new Dio();
      var uploadURL = "http://34.123.192.200:8000/api/search/";
    
      dio.post(uploadURL, data: {"name":text,"deviceId":deviceId}, options: Options(
      method: 'POST',
      responseType: ResponseType.json // or ResponseType.JSON
      ))
      .then((response) => {
            setState((){
              loading = false; 
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
              loading = false; 
            }),
        print(error),
        showAlertDialog(context,"Sorry, no matches found! Please share your email to be updated of new matches as we continuously update & enhance our database.")
        });
  
    
  
    }
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
            fontFamily:'Calibri',
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
                       color: Colors.orange,
                       fontSize: 16,
                       fontFamily: 'Calibri',
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
      if(!hasFocus && _valid){
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
      
      return loading? Loading(): Scaffold(
        appBar: CustomAppBar(
          "Know Your Food"
        ),
        body: Container(
          padding:  EdgeInsets.only(top: 60.0),
          margin: EdgeInsets.fromLTRB(15.0,50,15,90),
          decoration: BoxDecoration(
             color: Colors.lightGreen[200],
            border: Border.all(
              color:Colors.white
            ),
            borderRadius: BorderRadius.all(Radius.circular(40.0))
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal:35.0,vertical:2.0),
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:BorderRadius.all(Radius.circular(20.0)),

                
                ),
                child:TextFormField(
                  controller: _textController,
                  focusNode: _textFocus,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                     hintText:"Search",
                     hintStyle: TextStyle(
                       color: Colors.orange,
                       fontSize: 20,
                       fontFamily: 'Calibri',
                     ),
                     prefixIcon: IconButton(
                       icon: Icon(
                       Icons.search,
                       color: Colors.grey[600],
                       size: 30,
                       ),
                       padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                      onPressed: (){},
                     ),
                     
                  ),
                )
              ),
              Container(
                margin: EdgeInsets.fromLTRB(80,150,80,50),
                // padding: EdgeInsets.only(left:70,right:70),
                decoration: BoxDecoration(),
                child:RaisedButton(
                   color: Color(0xff73a632),
                   padding:EdgeInsets.fromLTRB(0,10,0,10) ,
                   shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center ,
                     children: [
                       Container(
                         child: Icon(
                           Icons.camera_alt,
                           size: 30,
                           ),
                       ),
                       Container(
                         child: Text(' Scan',
                         style: TextStyle(
                           fontSize: 24,
                           fontFamily: 'Calibri',
                           color: Colors.white,
                           fontWeight: FontWeight.bold
                         ),
                         ),
                       )
                     ],
                   ),
                  onPressed:() =>{
                      _showSelectionDialog(context)
                  },  
                )
              )
            ],
          ),
        )
      );
    }
  
    void _getId() async{
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
     
        AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
        deviceId =  androidDeviceInfo.androidId; // unique ID on Android      
    }
}