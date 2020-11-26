import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knowyourfood/additives.dart';



class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  File _image;
  String _uploadedFileURL;
  bool loading = false;

  TextEditingController _textController = new TextEditingController();

  FocusNode _textFocus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _textFocus.addListener(onChange);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _openCamera(context);
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
  
  Dio dio = new Dio();
  var uploadURL = "http://192.168.42.29:3000/api/image/";
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
        print(response),
        Navigator.pop(context),
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdditivePage()))

  })
  .catchError((error) => print(error));
  
  }

void _openCamera(BuildContext context) async {
  
    File picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      _image = picture;
    });
     Dio dio = new Dio();
  var uploadURL = "http://192.168.42.29:3000/api/image/";
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
        print(response),
        Navigator.pop(context),
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdditivePage()))
  })
  .catchError((error) => print(error));
    
  }


void onChange(){
  String text = _textController.text;
  bool hasFocus = _textFocus.hasFocus;
  //do your text transforming
  if(!hasFocus){
    print("Redirecting to additive page");
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdditivePage()));

  }
  print(text);
}


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
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
        margin: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
           color: Colors.green[100],
          border: Border.all(
            color:Colors.white
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.0))
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
              margin: EdgeInsets.only(top: 200),
              padding: EdgeInsets.only(left:70,right:70),
              decoration: BoxDecoration(),
              child:RaisedButton(
                 color: Colors.green,
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