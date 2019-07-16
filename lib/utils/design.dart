import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Design {

   static getBGDecoratedBox() { 
     return new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Color(0xff191923), Color(0xff0f101b)],
              //begin: new FractionalOffset(0.0,0.5),
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter, //new FractionalOffset(0.5, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        );
   }

  static fontStyle(double size, Color color) {
    return new TextStyle(fontSize: size, color: color, fontFamily: 'LeagueGothic', letterSpacing: 2.0);
  }
  
  static SectionSelectDecorate() {
    return BoxDecoration(
      color: Colors.blue,
      //border: new Border.all(color: Color(0xffaaaaff), width: 2.0),
      borderRadius: new BorderRadius.circular(5.0),
    );
  }

  static SectionDecorate() {
    return BoxDecoration(
      color: Colors.transparent,
      //border: new Border.all(color: Color(0xffaaaaff), width: 2.0),
      borderRadius: new BorderRadius.circular(5.0),
    );
  }

  static BorderDecoratate() {
    return BoxDecoration(
      // border: Border.all(color: Colors.white, width: 1.0),
      border: new Border.all(color: Color(0xffcccccc), width: 1.0),
      borderRadius: new BorderRadius.circular(5.0),
    );
  }
  static ButtonBlueDecorateBox() {
    return BoxDecoration(
      gradient: new LinearGradient(
        colors: [
          Color(0xff194368),
          Color(0xff120e24),
        ],
        begin: Alignment(0.5, -1.0),
        end: Alignment(0.5, 1.0),
      ),
      // border: Border.all(color: Colors.white, width: 1.0),
      border: new Border.all(color: Color(0xff28b8ff), width: 2.0),
      borderRadius: new BorderRadius.circular(5.0),
    );
  }

  static ButtonPinkDecorateBox() {
    return BoxDecoration(
      gradient: new LinearGradient(
        colors: [
          Color(0xff5a094b),
          Color(0xff2f0c33),
          
        ],
        begin: Alignment(0.5, -1.0),
        end: Alignment(0.5, 1.0),
      ),
      // border: Border.all(color: Colors.white, width: 1.0),
      borderRadius: new BorderRadius.circular(5.0),
      border: new Border.all(color: Color(0xffff00a4), width: 2.0),
    );
  }
}