import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:knowyourfood/registration.dart';

import 'List.dart';
import 'additives.dart';
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

  @override
  void initState() {
    super.initState();
    getRecognisedText(widget._image);
    initialText = '';
    _editingController = TextEditingController(text: initialText);
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
    FormData formdata = new FormData.fromMap({
          "image":
              await MultipartFile.fromFile(_image.path, filename:fileName),
          "deviceId":widget.deviceId    
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
      print(error),
      setState((){
        buffering = false;
      }),
      showAlertDialog(context,"Sorry, no matches found! Please share your email to be updated of new matches as we continuously update & enhance our database.")
      });
  }

  Widget _editTitleTextField() {
  if (_isEditingText)
    return Center(
      child: TextField(
        maxLines: 10,
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
  
      dio.post(uploadURL, data: {"name":text.trim(),"deviceId":widget.deviceId}, options: Options(
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
  

  @override
  Widget build(BuildContext context) {
    return  loading? Loading(): Scaffold(
        appBar: CustomAppBar("Know Your Food"),
        body: ListView(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
            child: Text(
              "Image",
              style: TextStyle(
                color: HexColor('#72a633'),
                fontSize: 24,
                fontFamily: 'PlutoCondMedium',
              ),
            ),
          ),
          Container(
            // padding: EdgeInsets.only(top:60),
            margin: EdgeInsets.fromLTRB(15.0, 20, 15, 20),
            child: Image.file(widget._image),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              "Recognised Text",
              style: TextStyle(
                color: HexColor('#72a633'),
                fontSize: 24,
                fontFamily: 'PlutoCondMedium',
              ),
            ),
          ),
          buffering?Container(color: Colors.white,child: Buffering()):Stack(
          children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              padding: EdgeInsets.fromLTRB(10,30,10,10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Column(
                children:[
                  Row(),
                  _editTitleTextField()
                ]
              )),
          Align(
            alignment: Alignment(0,0),
            child:_isEditingText? Container(
               decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(100))
                ),
              
              child:IconButton(
              icon:Icon(Icons.check),
              iconSize: 30,
              color: Colors.white,
              onPressed: (){
                setState(() {
                  _isEditingText = false;
                });
              },
              )):
               Container(
               decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(100))
                ),
              
              child:IconButton(
              icon:Icon(Icons.edit),
              iconSize: 30,
              color: Colors.white,
              onPressed: (){
                setState(() {
                  _isEditingText = true;
                });
              },
              ))
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
        ]));
  }
}
