import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  File _image;
  String _uploadedFileURL;


  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
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
    StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child('productImages/${Path.basename(_image.path)}}');    
   StorageUploadTask uploadTask = storageReference.putFile(_image);    
   await uploadTask.onComplete;    
   print('File Uploaded');    
   storageReference.getDownloadURL().then((fileURL) async {    
     setState(() {    
       _uploadedFileURL = fileURL;    
     });
    await databaseReference.collection("productsData")
      .add({
        'UID': 'AaJeAuvlH9Zyb04IxH53PIfaxGm2',
        'imageUrl': fileURL,
        'timeStamp': DateTime.now()
      });
    Navigator.of(context).pop();
    print('Record saved!');     
   }); 
  }

void _openCamera(BuildContext context) async {
    File picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      _image = picture;
    });
    StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child('productImages/${Path.basename(_image.path)}}');    
   StorageUploadTask uploadTask = storageReference.putFile(_image);    
   await uploadTask.onComplete;    
   print('File Uploaded');    
   storageReference.getDownloadURL().then((fileURL) {    
     setState(() {    
       _uploadedFileURL = fileURL; 
       print(_uploadedFileURL);   
     });
     storageReference.getDownloadURL().then((fileURL) async {    
     setState(() {    
       _uploadedFileURL = fileURL;    
     });
    await databaseReference.collection("productsData")
      .add({
        'UID': "AaJeAuvlH9Zyb04IxH53PIfaxGm2",
        'imageUrl': fileURL,
        'timeStamp': DateTime.now()
      });
    Navigator.of(context).pop();
    print('Record saved!');    
   });     
   }); 
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Know Your Food'),
        backgroundColor: Colors.green, 
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