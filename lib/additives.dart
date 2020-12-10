import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:knowyourfood/additive_detail.dart';
import 'package:knowyourfood/custom_app_bar.dart';


class AdditivePage extends StatefulWidget {
  // final dynamic dataList = ["Additive1","Additive2","Additive3","Additive4","Additive5","Additive6","Additive7","Additive8","Additive9"];
  final List<String> dataList;
  AdditivePage({Key key, @required this.dataList}) : super(key: key);

  @override
  _AdditivePageState createState() => _AdditivePageState();
}

class _AdditivePageState extends State<AdditivePage> {

 final databaseReference = FirebaseFirestore.instance;
 bool _valid = true;

 TextEditingController _textController = new TextEditingController();
 FocusNode _textFocus = new FocusNode();
 String deviceId; 

  @override
  void initState() {
    super.initState();
    _getId();
    _textFocus.addListener(onChange);
  }

  Future<void> onChange() async {
    String text = _textController.text;
    bool hasFocus = _textFocus.hasFocus;
    //do your text transforming
    if(!hasFocus && _valid){
      print(text);
      await databaseReference.collection("emailData")
        .add({
          'email':text,
          'deviceId':deviceId,
          'timeStamp': DateTime.now()
        }).then((response) {
      showAlertDialog(context, "Successfully submitted");
    }).timeout(Duration(seconds:10)).catchError((error) {
      print(error);
    });
      _textController.text = '';
    }
  }


  bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
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
    title: Text("Email"),  
    content: Text(message),  
    actions: [  
      okButton,  
    ],  
  );  
    },  
  );  
}  

void _getId() async{
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
     
        AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
        deviceId =  androidDeviceInfo.androidId; // unique ID on Android      
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar:CustomAppBar2("Know Your Food"),
        body:Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30, 40, 30, 40) ,
            child: Text("Additives present",
            style: TextStyle(
              color:Colors.green[900],
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Calibri',
            ),
            ),
          ),
        Expanded(
          child:ListView(
            children:buildList(context,widget.dataList),
          )
        ),
         Container(
           child: Text("For further information",
           style:  TextStyle(
                     color: Colors.black,
                     fontSize: 16,
                     fontFamily: 'Calibri',
                     fontWeight: FontWeight.bold,
                   ),
           ),
         ),
         Container(
              margin: EdgeInsets.symmetric(horizontal:30.0,vertical:2.0),
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:BorderRadius.all(Radius.circular(20.0)),
             

              ),
              child:TextFormField(
                controller: _textController,
                focusNode: _textFocus,
                decoration:_valid? InputDecoration(
                  border: InputBorder.none,
                   hintText:"Please enter email",
                   hintStyle: TextStyle(
                     color: Colors.orange,
                     fontSize: 16,
                     fontFamily: 'Calibri',
                     fontWeight: FontWeight.bold,
                   ),
                   icon: Icon(Icons.email,color: Colors.black)

                ):
                InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                    color: Colors.red,
                  ),
                  ),
                   labelText:"invalid email",
                   labelStyle: TextStyle(
                     color: Colors.red,
                     fontSize: 12,
                     fontFamily: 'Calibri',
                     fontWeight: FontWeight.bold,
                   ),
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
      )      
    );
  }
}



 List<Widget> buildList(context,dataList){
   var row;
    List<Widget> list = [Container(
         padding: EdgeInsets.fromLTRB(20,10,0,10),
         color: Colors.green[100],
         child: Text("Additive Name",
         style: TextStyle(
           fontSize:18,
           color:Colors.orange,
           fontWeight: FontWeight.bold,
           fontFamily: 'Calibri',
         ),),
       )];
   var f=0;
   for(var i=0;i<dataList.length;i++){
     if(f==0){
       row =GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdditiveDetail(additive:dataList[i])));
        },
        child: Container(
         padding: EdgeInsets.fromLTRB(20,10,0,10),
         color: Colors.green[50],
         child: Text(dataList[i],
         style: TextStyle(
           fontSize:16,
           color:Colors.black,
           fontFamily: 'Calibri',
           fontWeight: FontWeight.bold,
         ),),
       )
       );
     f=1;
     }else{
       row =GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdditiveDetail(additive:dataList[i])));
        },
        child: Container(
         padding: EdgeInsets.fromLTRB(20,10,0,10),
         color: Colors.green[100],
         child: Text(dataList[i],
         style: TextStyle(
           fontSize:16,
           color:Colors.black,
           fontFamily: 'Calibri',
           fontWeight: FontWeight.bold,
         ),),
       )
       );
     f=0;
     }
      list.add(row);
   }
   return list;
 } 