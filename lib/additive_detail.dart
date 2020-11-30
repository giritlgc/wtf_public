import 'package:flutter/material.dart';


class AdditiveDetail extends StatefulWidget {
  final String additive;
  AdditiveDetail({Key key, @required this.additive}) : super(key: key);
  
  final dynamic dataList = ["Functionality1","Functionality2","Functionality3","Functionality4","Functionality5","Functionality6","Functionality7","Functionality8","Functionality9"];
  @override
  _AdditiveDetailState createState() => _AdditiveDetailState();
}

class _AdditiveDetailState extends State<AdditiveDetail> {
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
            child: Text(widget.additive,
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
        ),
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
         child: Text("Functionalities",
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
         ),
         ),
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