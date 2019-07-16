import 'dart:io';

import 'package:flutter/material.dart';
import '../../utils/design.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../utils/strings.dart';

class WalletAdd extends StatefulWidget {
  final String userid;

  WalletAdd(this.userid);

  @override
  _WalletAddState createState() => _WalletAddState(userid);
}

class _WalletAddState extends State<WalletAdd> {

  _WalletAddState(this.userid);

  String userid;

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  int selectSegment = 1;

  prepareNewWallet() {

    String crypto = (selectSegment==1? "Ethereum" : "Bitcoin");
    String address = addressController.text;

    _showDialog("Add $crypto Wallet","Address:\n$address\n");
  }

  void _showDialogFinish(String title, String detail) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(detail),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                addressController.clear();
                nameController.clear();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog(String title, String detail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(detail),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                registerNewWallet();
              },
            ),
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  registerNewWallet() async {
    String url = "https://########################";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      if (map['code']==0)
      {
        final w = map['data'];
        _showDialogFinish("Add Wallet","Finished");
      }
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [Color(0xff191923), Color(0xff0f101b)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),

          child: 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20,),
                    Row( 
                      children: [
                        BackButton(color: Colors.white,),
                      ]
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'ADD WALLET',
                      style: Design.fontStyle(22.0, Colors.white)
                    ),
                    SizedBox(height: 20,),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                                child:Column (
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 20,),
                                    Text('Select type of the wallet', style: TextStyle(color: Colors.white, fontSize: 12,)),
                                    SizedBox(height: 10,),

                                    Row(
                                      mainAxisAlignment:  MainAxisAlignment.center,

                                      children: <Widget>[
                                         
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.8,
                                          height: 50.0,
                                          decoration: Design.BorderDecoratate(),
                                          child: Row(children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.4 - 1,
                                                height: 50.0,
                                                decoration: selectSegment==1 ? Design.SectionSelectDecorate() : Design.SectionDecorate(),
                                                child: new Material(
                                                  child: MaterialButton(
                                                    child: Text('ETHEREUM',
                                                      style: Design.fontStyle(17.0, Colors.white),
                                                    ),
                                                    onPressed: (){setState(() {
                                                      selectSegment = 1;
                                                    });},
                                                  ),
                                                  color: Colors.transparent,
                                                  borderRadius: new BorderRadius.circular(30.0),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.4 - 1,
                                                height: 50.0,
                                                decoration: selectSegment==2 ? Design.SectionSelectDecorate() : Design.SectionDecorate(),
                                                child: new Material(
                                                  child: MaterialButton(
                                                    child: Text('BITCOIN',
                                                      style: Design.fontStyle(17.0, Colors.white),
                                                    ),
                                                    onPressed: (){ setState(() {
                                                      selectSegment = 2;
                                                    });},
                                                  ),
                                                  color: Colors.transparent,
                                                  borderRadius: new BorderRadius.circular(30.0),
                                                ),
                                              ),
                                          ],),
                                        ),
                                        
                                      ],
                                    ),
                                  
                                    SizedBox(height: 20,),
                                    Text('Enter name of the wallet', style: TextStyle(color: Colors.white, fontSize: 12,)),
                                    SizedBox(height: 10,),
                                    TextFormField(
                                        controller: nameController,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12
                                        ),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                    const BorderSide(color: Color(0xff49485b))),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.all(Radius.circular(5.0)),
                                                borderSide: BorderSide(color: Colors.red)
                                            )
                                          )
                                        ),
                                    SizedBox(height: 20,),
                                    Text('Enter wallet address or scan QRCode', style: TextStyle(color: Colors.white, fontSize: 12,)),
                                    SizedBox(height: 10,),
                                    new Stack(
                                        alignment: const Alignment(1.0, 1.0),
                                        children: <Widget>[
                                          TextFormField(
                                          controller: addressController,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12
                                        ),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                    const BorderSide(color: Color(0xff49485b))),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.all(Radius.circular(5.0)),
                                                borderSide: BorderSide(color: Colors.red)
                                            )
                                          )
                                        ),
                                        Container(
                                          width: 90.0,
                                          height: 50.0,
                                          decoration: Design.ButtonBlueDecorateBox(),
                                          child: new Material(
                                            child: MaterialButton(
                                              child: Text('SCAN QR',
                                                style: Design.fontStyle(17.0, Colors.white),
                                              ),
                                              onPressed: (){},
                                              //highlightColor: Colors.orange.withOpacity(0.5),
                                              //splashColor: Colors.orange.withOpacity(0.5),
                                            ),
                                            color: Colors.transparent,
                                            borderRadius: new BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        ]
                                    ),

                                  ],
                                )
                            )
                          ]
                        ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50.0,
                      decoration: Design.ButtonBlueDecorateBox(),
                      child: new Material(
                        child: MaterialButton(
                          child: Text('NEXT',
                            style: Design.fontStyle(24.0, Colors.white),
                          ),
                          onPressed: (){ prepareNewWallet();},
                        ),
                        color: Colors.transparent,
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    
                  ],

                ),
              )
            ),
          )
        )
      );
  }
}