import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final _preferredSize = 125.0;

  final String title;

  CustomAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _preferredSize,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(color: HexColor('#72a633')),
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/charaka.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    "What the Food?",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'GrotaRoundedExtraBold',
                        color: Colors.white),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_preferredSize);
}

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final _preferredSize = 125.0;

  final String title;

  CustomAppBar2(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _preferredSize,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(color: HexColor('#72a633')),
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment(-1, 0),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              iconSize: 30,
              onPressed: () => {Navigator.pop(context)},
            ),
          ),
          Align(
              alignment: Alignment.center,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  'images/charaka.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                Text(
                  "What the Food?",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'GrotaRoundedExtraBold',
                      color: Colors.white),
                )
              ]))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_preferredSize);
}

class CustomAppBar3 extends StatelessWidget implements PreferredSizeWidget {
  final _preferredSize = 125.0;

  final String title;

  CustomAppBar3(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _preferredSize,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(color: HexColor('#e9ce3f')),
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment(-0.99, 0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  color: Colors.grey[500],
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment(1, 0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  'images/charaka.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                Text(
                  "What the Food?",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'GrotaRoundedExtraBold',
                      color: Colors.white),
                )
              ]))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_preferredSize);
}

class CustomAppBar4 extends StatelessWidget implements PreferredSizeWidget {
  final _preferredSize = 125.0;

  final String title;

  CustomAppBar4(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _preferredSize,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(color: HexColor('#e9ce3f')),
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/charaka.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    "What the Food?",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'GrotaRoundedExtraBold',
                        color: Colors.white),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_preferredSize);
}
