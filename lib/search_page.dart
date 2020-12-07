import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knowyourfood/AdditiveList.dart';
import 'package:knowyourfood/additives.dart';
import 'package:knowyourfood/loader.dart';



class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  File _image;
  // String _uploadedFileURL;
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
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                        Navigator.pop(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
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
  
    dio.post(uploadURL, data: {"name":text}, options: Options(
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
        Text(message),
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
      appBar:PreferredSize(
          preferredSize: Size.fromHeight(95.0),
          child: AppBar(
           automaticallyImplyLeading: false,
           flexibleSpace: Container(),
           centerTitle: true,
      title: Padding(
            padding: const EdgeInsets.only(top:30.0),
        child: Row(
        children: <Widget>[
          Image.asset(            
                'images/charaka.png',
                width: 40,
                height: 40,            
                fit: BoxFit.cover,            
            ),
          Text("Know Your Food.",
          style: TextStyle(
           fontSize: 32,
           fontWeight: FontWeight.bold,  
          ),
          )
        ],
      ),
     ),
     
    backgroundColor: Colors.green, 
    ),
   ),
      body: Container(
        padding:  EdgeInsets.only(top: 40.0),
        margin: EdgeInsets.fromLTRB(30.0,25,30,90),
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
              margin: EdgeInsets.symmetric(horizontal:30.0,vertical:2.0),
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
                   ),
                   icon: Icon(Icons.search,color: Colors.black)

                ),
              )
            ),
            Container(
              margin: EdgeInsets.fromLTRB(65,200,65,0),
              // padding: EdgeInsets.only(left:70,right:70),
              decoration: BoxDecoration(),
              child:RaisedButton(
                 color: Colors.green,
                 shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                 child: Row(
                   children: [
                     Container(
                       child: Icon(Icons.camera_alt),
                     ),
                     Container(
                       child: Text(' Scan',
                       style: TextStyle(
                         fontSize: 40,
                         color: Colors.white
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
}