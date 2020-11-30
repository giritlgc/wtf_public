import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:knowyourfood/additive_detail.dart';


class AdditivePage extends StatefulWidget {
  final dynamic dataList = ["Additive1","Additive2","Additive3","Additive4","Additive5","Additive6","Additive7","Additive8","Additive9"];

  @override
  _AdditivePageState createState() => _AdditivePageState();
}

class _AdditivePageState extends State<AdditivePage> {

 final databaseReference = FirebaseFirestore.instance;
 bool _valid = true;

 TextEditingController _textController = new TextEditingController();
  FocusNode _textFocus = new FocusNode();

  @override
  void initState() {
    super.initState();

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar:PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
           automaticallyImplyLeading: false,
           flexibleSpace: Container(),
           centerTitle: true,
      title: Padding(
            padding: const EdgeInsets.only(top:30.0),
        child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton (icon:Icon(Icons.arrow_back),
           onPressed: ()=>{
             Navigator.pop(context)
           },),
           Image.asset(            
                'images/charaka.png',
                width: 40,
                height: 40,            
                fit: BoxFit.cover,            
            ),
          Text("Know Your Food.",
          style: TextStyle(
           fontSize: 32,
           fontWeight: FontWeight.bold 
          ),)
        ],
      ),
     ),
     
    backgroundColor: Colors.green, 
    ),
   ),
     body:Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30, 40, 30, 40) ,
            child: Text("Additives present",
            style: TextStyle(
              color:Colors.green[900],
              fontSize: 30,
              fontWeight: FontWeight.w500
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
                     fontSize: 12
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
         padding: EdgeInsets.all(20),
         color: Colors.green[100],
         child: Text("Additive Name",
         style: TextStyle(
           fontSize:18,
           color:Colors.orange,
           fontWeight: FontWeight.bold
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
         padding: EdgeInsets.all(20),
         color: Colors.green[50],
         child: Text(dataList[i],
         style: TextStyle(
           fontSize:16,
           color:Colors.black
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
         padding: EdgeInsets.all(20),
         color: Colors.green[100],
         child: Text(dataList[i],
         style: TextStyle(
           fontSize:16,
           color:Colors.black
         ),),
       )
       );
     f=0;
     }
      list.add(row);
   }
   return list;
 } 