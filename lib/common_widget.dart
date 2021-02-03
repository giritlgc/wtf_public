import "package:flutter/material.dart";
import 'package:hexcolor/hexcolor.dart';


showAlert(BuildContext context, String message) {  
  // Create button  
  Widget okButton = RaisedButton(  
    child: Padding(
      padding: const EdgeInsets.fromLTRB(4,0,4,0),
      child: Text("OK",
      style: TextStyle(
          fontFamily: 'PlutoCondRegular',
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      ),
    ), 
    color:HexColor('#76af2c'),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)
      )
    ), 
    onPressed: () {  
      Navigator.of(context).pop();  
    },  
  );  
  
  
  // show the dialog  
  showDialog(  
    context: context,  
    builder: (BuildContext context) { 
      return AlertDialog(  
    backgroundColor: HexColor("#f38343"), 
    content: Text(message,
    style: TextStyle(
      fontFamily: 'PlutoCondRegular',
      color: Colors.white
    ),
    ), 
    actionsPadding: EdgeInsets.fromLTRB(0, 0, 15, 0), 
    actions: [  
      okButton,  
    ],  
  );  
    },  
  );  
}  
