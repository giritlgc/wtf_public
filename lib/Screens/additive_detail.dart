import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:knowyourfood/FunctionalityList.dart';
import 'package:knowyourfood/CommonComponents/custom_app_bar.dart';
import 'package:knowyourfood/CommonComponents/loader.dart';

class AdditiveDetail extends StatefulWidget {
  final String additive;
  AdditiveDetail({Key key, @required this.additive}) : super(key: key);

  @override
  _AdditiveDetailState createState() => _AdditiveDetailState();
}

class _AdditiveDetailState extends State<AdditiveDetail> {
  FunctionalityList functionalityList;
  var dataList = [];

  @override
  void initState() {
    super.initState();
    buffering = true;
    Dio dio = new Dio();
    var uploadURL = "http://35.223.112.99:8000/api/functionality/";
    dio
        .post(uploadURL,
            data: {"name": widget.additive},
            options: Options(
                method: 'POST',
                responseType: ResponseType.json // or ResponseType.JSON
                ))
        .then((response) => {
              print(response),
              functionalityList =
                  FunctionalityList.fromJson(jsonDecode(response.toString())),
              print(functionalityList.functionalities),
              setState(() {
                buffering = false;
                dataList = functionalityList.functionalities;
              }),
            })
        .catchError((error) => {print(error)});
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
                  widget.additive,
                  style: TextStyle(
                      color: HexColor('#5ca4b8'),
                      fontSize: 30,
                      fontFamily: 'PlutoCondMedium'),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                // color: HexColor('#dbeaef'),
                child: Text(
                  "Possible Effects",
                  style: TextStyle(
                      fontSize: 18,
                      color: HexColor('#e58149'),
                      fontFamily: 'PlutoCondMedium'),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                // color: HexColor('#eff7f9'),
                child: Text(
                  "Known human lung and skin toxicity, May contribute to endogenous nitrosamine formation(CIR), Environmental and wildlife toxicity, Suspected liver and immunotoxicity (Scorecard), Skinsensitisation, Safe up to 0.1% with qualifications (CIR)",
                  style: TextStyle(
                    fontSize: 16,
                    color: HexColor('#635950'),
                    fontFamily: 'PlutoCondMedium',
                  ),
                ),
              ),
              Container(
      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
      color: HexColor('#dbeaef'),
      child: Row(
        children: [
          Text(
            "Functionalities",
            style: TextStyle(
                fontSize: 18,
                color: HexColor('#e58149'),
                fontFamily: 'PlutoCondMedium'),
          ),
        ],
      ),
    ),
              Expanded(
                  child: ListView(
                children: buildList(dataList),
              )),
            ]));
  }
}

bool buffering = true;

List<Widget> buildList(dataList) {
  var row;
  List<Widget> list = [];
  var f = 0;
  for (var i = 0; i < dataList.length; i++) {
    if (f == 0) {
      row = Container(
        padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
        color: HexColor('#eff7f9'),
        child: Text(
          dataList[i],
          style: TextStyle(
            fontSize: 16,
            color: HexColor('#635950'),
            fontFamily: 'PlutoCondMedium',
          ),
        ),
      );
      f = 1;
    } else {
      row = Container(
        padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
        color: HexColor('#dbeaef'),
        child: Text(
          dataList[i],
          style: TextStyle(
            fontSize: 16,
            color: HexColor('#635950'),
            fontFamily: 'PlutoCondMedium',
          ),
        ),
      );
      f = 0;
    }
    list.add(row);
  }
  if (buffering) {
    list.add(Container(
        // color: HexColor('#eff7f9'),
        child: Buffering()));
  }
  return list;
}
