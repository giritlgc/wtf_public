import 'package:flutter/material.dart';


class AdditivePage extends StatefulWidget {
  final dynamic dataList = ["Additive1","Additive2","Additive3","Additive4","Additive5","Additive6","Additive7","Additive8","Additive9"];

  @override
  _AdditivePageState createState() => _AdditivePageState();
}

class _AdditivePageState extends State<AdditivePage> {

 

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
            children:buildList(widget.dataList),
          )
        )
        ]
      )      
    );
  }
}



 List<Widget> buildList(dataList){
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
       row = Container(
         padding: EdgeInsets.all(20),
         color: Colors.green[50],
         child: Text(dataList[i],
         style: TextStyle(
           fontSize:16,
           color:Colors.black
         ),),
       );
     f=1;
     }else{
       row = Container(
         padding: EdgeInsets.all(20),
         color: Colors.green[100],
         child: Text(dataList[i],
         style: TextStyle(
           fontSize:16,
           color:Colors.black
         ),),
       );
     f=0;
     }
      list.add(row);
   }
   return list;
 } 