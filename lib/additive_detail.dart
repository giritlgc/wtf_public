import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:knowyourfood/custom_app_bar.dart';


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
          appBar: CustomAppBar2("Know Your Food2"),
      body:Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30, 40, 30, 40) ,
            child: Text(widget.additive,
            style: TextStyle(
              color: HexColor('#72a633'),
              fontSize: 30,
              fontFamily: 'PlutoCondMedium'
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
         padding: EdgeInsets.fromLTRB(20,10,0,10),
         color: HexColor('#d1e0bc'),
         child: Text("Functionalities",
         style: TextStyle(
           fontSize:18,
           color:HexColor('#e58149'),
           fontFamily: 'PlutoCondMedium'
         ),),
       )];
   var f=0;
   for(var i=0;i<dataList.length;i++){
     if(f==0){
       row = Container(
         padding: EdgeInsets.fromLTRB(20,10,0,10),
         color: HexColor('#ebf3e3'),
         child: Text(dataList[i],
         style: TextStyle(
           fontSize:16,
           color:HexColor('#635950'),
           fontFamily: 'PlutoCondMedium',
         ),
         ),
       );
     f=1;
     }else{
       row = Container(
         padding: EdgeInsets.fromLTRB(20,10,0,10),
         color: HexColor('#d1e0bc'),
         child: Text(dataList[i],
         style: TextStyle(
           fontSize:16,
           color:HexColor('#635950'),
           fontFamily: 'PlutoCondMedium',
         ),),
       );
     f=0;
     }
      list.add(row);
   }
   return list;
 } 