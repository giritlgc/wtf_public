import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:knowyourfood/Screens/additive_detail.dart';
import 'package:knowyourfood/CommonComponents/custom_app_bar.dart';
import 'package:knowyourfood/custom_showcasewidget.dart';
import 'package:showcaseview/showcase_widget.dart';

class AdditivePage extends StatefulWidget {
  // final dynamic dataList = ["Additive1","Additive2","Additive3","Additive4","Additive5","Additive6","Additive7","Additive8","Additive9"];
  final List<String> dataList;
  AdditivePage({Key key, @required this.dataList}) : super(key: key);

  @override
  _AdditivePageState createState() => _AdditivePageState();
}

class _AdditivePageState extends State<AdditivePage> {
  @override
  void initState() {
    super.initState();
  }

  final keyOne = GlobalKey();

  List<Widget> buildListView(context,dataList){
   var row;
    List<Widget> list = [];
   var f=0;
   for(var i=0;i<dataList.length;i++){
     if(f==0){
       row =GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdditiveDetail(additive:dataList[i])));
        },
        child: 
        Container(
         padding: EdgeInsets.fromLTRB(20,10,0,10),
         color: HexColor('#eff7f9'),
         child: Text(dataList[i],
         style: TextStyle(
           fontSize:16,
           color:HexColor('#635950'),
           fontFamily: 'PlutoCondMedium',
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
         color: HexColor('#dbeaef'),
         child: Text(dataList[i],
         style: TextStyle(
           fontSize:16,
           color:HexColor('#635950'),
           fontFamily: 'PlutoCondMedium',
         ),),
       )
       );
     f=0;
     }
      list.add(row);
   }
   return list;
 } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar3("What the Food?"),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(20, 40, 20, 40),
                child: Text(
                  "Possible Additive Matches",
                  style: TextStyle(
                    color: HexColor('#5ca4b8'),
                    fontSize: 30,
                    fontFamily: 'PlutoCondMedium',
                  ),
                ),
              ),
              CustomShowcaseWidget(
                              description: 'Click on below additive names to know its functionality',  
                            globalKey: keyOne,
                            child:
     Container(
         padding: EdgeInsets.fromLTRB(20,10,0,10),
         color: HexColor('#dbeaef'),
         child: Row(
           children: [
             Text("Additive Name",
             style: TextStyle(
               fontSize:18,
               color:HexColor('#e58149'),
               fontFamily: 'PlutoCondMedium',
             ),),
           ],
         ),
       )),
              Expanded(
                  child:   ListView(
                      children: buildListView(context, widget.dataList))),
              Padding(
                  padding: const EdgeInsets.only(bottom:20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          ShowCaseWidget.of(context).startShowCase([
                            keyOne
                          ]);
                        },
                        color: Colors.white,
                        textColor: HexColor("#f38343"),
                        child: Text(
                          "?",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            
                          ),
                        ),
                        padding: EdgeInsets.all(8),
                        shape: CircleBorder(
                          side: BorderSide(
                            color: HexColor("#f38343"),
                            width: 5)
                        ),
                      ),
                    ],
                  ),
                )
              
            ]));
  }
}

