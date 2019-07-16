import 'package:flutter/material.dart';

class BoardPage extends StatelessWidget {
  String line1 = '';
  String line2 = '';
  String line3 = '';
  String logoImage = '';
  
  BoardPage(this.line1, this.line2, this.line3, this.logoImage);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment:  MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          this.logoImage,
          // width: 200,
          height: 200,
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          // child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(this.line1, style: TextStyle(color: Colors.white, fontSize: 16)),
              Text(this.line2, style: TextStyle(color: Colors.white, fontSize: 16)),
              Text(this.line3, style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          // )
          ),
        ),
        SizedBox(height: 30,),
      ],
    ));
  }
}