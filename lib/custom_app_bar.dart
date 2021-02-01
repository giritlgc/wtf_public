import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:knowyourfood/Auth.dart';
import 'package:knowyourfood/login.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final _preferredSize =125.0;
  
  final String title;

  CustomAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _preferredSize,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top:20.0),
      decoration: BoxDecoration(
        color: HexColor('#72a633')
      ),
      child: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Align(
            alignment: Alignment.center,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Image.asset(            
                'images/charaka.png',
                width: 60,
                height: 60,            
                fit: BoxFit.cover,            
              ),
              Text("Know Your Food.",
              style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'ColbyCompressed' ,
              color: Colors.white
              ),
              ),
          
             ],
           )
           )
        ],
      ),
    
      
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_preferredSize);
}

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget{
  final _preferredSize =125.0;
  
  final String title;

  CustomAppBar2(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _preferredSize,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top:20.0),
      decoration: BoxDecoration(
        color: HexColor('#72a633')
      ),
      child: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment(-1, 0),
            child:  IconButton (icon:Icon(Icons.arrow_back,color:Colors.white),
              iconSize: 30,
              onPressed: ()=>{
                Navigator.pop(context)
              },
            ),
          ),
         
          Align(
            alignment:Alignment.center,
            child:Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children:[
                Image.asset(            
                'images/charaka.png',
                width: 60,
                height: 60,            
                fit: BoxFit.cover,            
            ),
                Text("Know Your Food.",
                style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'ColbyCompressed' ,
                color: Colors.white
                ),)
              ]
            )
          ) 
        ],
      ),
    
      
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_preferredSize);
}

class CustomAppBar3 extends StatefulWidget implements PreferredSizeWidget{
  @override
  _CustomAppBar3State createState() => _CustomAppBar3State();

  @override
  Size get preferredSize => Size.fromHeight(125.0);
}

class _CustomAppBar3State extends State<CustomAppBar3> {

  bool loggedIn = FirebaseAuth.instance.currentUser != null;

  decisionAlertDialog(BuildContext context) {

  // set up the button
  Widget yes = FlatButton(
    child: Text("Yes",
    style: TextStyle(
        fontFamily: 'PlutoCondRegular'
      ),
    ),
    onPressed: () { 
      
      // FirebaseAuth.instance.signOut().then((value) => {
      //   Navigator.of(context).pop(),
      //   setState(() {
      //     loggedIn = false;
      //     showAlertDialogEmail(context, "User logged out!");
      //   })
      // });
      signOutUser().whenComplete(() => {
        Navigator.of(context).pop(),
        setState(() {
          loggedIn = false;
          showAlertDialogEmail(context, "User logged out!");
        })
      });
    },
  );

   Widget no = FlatButton(
    child: Text("No",
    style: TextStyle(
        fontFamily: 'PlutoCondRegular'
      ),
    ),
    onPressed: () { 
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Logout!"),
    content: Text("Do you want to logout?",
    style: TextStyle(
        fontFamily: 'PlutoCondRegular'
      ),
    ),
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

showAlertDialogEmail(BuildContext context, String message) {  
    // Create button  
    Widget okButton = FlatButton(  
      child: Text("OK",
      style: TextStyle(
        fontFamily: 'PlutoCondRegular'
      ),
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
      title: Text(""),  
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
  


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top:20.0),
      decoration: BoxDecoration(
        color: HexColor('#72a633')
      ),
      child: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Align(
            alignment: Alignment.center,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Image.asset(            
                'images/charaka.png',
                width: 60,
                height: 60,            
                fit: BoxFit.cover,            
              ),
              Text("Know Your Food.",
              style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'ColbyCompressed' ,
              color: Colors.white
              ),
              ),
              loggedIn
                  ? InkWell(
                      child: Padding(
                        padding: EdgeInsets.only(left:0.0),
                        child: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 40.0,
                ),
                      ),
                      onTap: () {
                  decisionAlertDialog(context);
                },
                    )
                  : InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(top:0.0),
                        child: Icon(
                  Icons.login,
                  color: Colors.white,
                  size: 40.0,
                ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login()));
                },
              )
             ],
           )
           )
        ],
      ),
    
      
    );

  }
}