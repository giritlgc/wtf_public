import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final _preferredSize =110.0;
  
  String title;

  CustomAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _preferredSize,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top:20.0),
      decoration: BoxDecoration(
        color: Color(0xff73a632)
      ),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          
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
           fontFamily: 'Colby' ,
           color: Colors.white
          ),)
        ],
      ),
    
      
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_preferredSize);
}

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget{
  final _preferredSize =110.0;
  
  String title;

  CustomAppBar2(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _preferredSize,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top:20.0),
      decoration: BoxDecoration(
        color: Color(0xff73a632)
      ),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton (icon:Icon(Icons.arrow_back),
           onPressed: ()=>{
             Navigator.pop(context)
           },),
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
           fontFamily: 'Colby' ,
           color: Colors.white
          ),)
        ],
      ),
    
      
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_preferredSize);
}