import 'package:flutter/material.dart';
import 'dart:async';
import '../model/user.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/src/utils/numbers.dart' as numbers;

class BuyReview extends StatefulWidget {
  String amount;
  String toWallet;
  String userid;

  BuyReview(this.userid,this.amount,this.toWallet);

  @override
  _BuyReviewState createState() => _BuyReviewState(userid,amount,toWallet);
}

class _BuyReviewState extends State<BuyReview> {

  String userid;
  String amount;
  String toWallet;
  String txHash;

  bool isPopup = false;

  _BuyReviewState(this.userid,this.amount,this.toWallet);

  doneAndBack() {
    Navigator.pop(context);
    Navigator.pop(context);
  }
  _hr() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 0.3,
      child: const DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.grey
        ),
      ), 
    );
  }

  User my = null;

  BigInt convertEth(String c) {
    double b = double.parse(c) * 1000000;
      BigInt a = BigInt.from(b);
      a = a * BigInt.from(1000000000000);
      return a;
  }

  getUser(String id) async {
    // User u = null;
    String url = "https://###############";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      if (map['code']=='0')
      {
        final user = map['data'][0];
        setState(() {
          my = new User(user['id'],user['username']);
        });
        
      }
    } 
  }

  Future _askUser() async {
    switch(
    await showDialog(
        context: context,
        child: 
        new SimpleDialog(
          backgroundColor: Color(0xff242534),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.circular(5)
          ),
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              new Text('Transfer ',style: TextStyle(color: Colors.white, fontFamily: 'LeagueGothic', fontSize: 24),),
              new Text('Result',style: TextStyle(color: Colors.blue, fontFamily: 'LeagueGothic', fontSize: 24),),
          ],),
          children: <Widget>[  
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _hr(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      Text('Transaction ID', style: TextStyle(color: Colors.white, fontSize: 16),),
                      SizedBox(height: 10,),
                      Text('d8dd2234', style: TextStyle(color: Colors.grey, fontSize: 12),),
                    ],)
                      
                  ),
                  _hr(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Send ', style: TextStyle(color: Colors.white, fontSize: 16),),
                          Text('0.222ETH', style: TextStyle(color: Colors.blue, fontSize: 16),),
                        ],
                      ),
                      Text('to address below', style: TextStyle(color: Colors.white, fontSize: 14),),
                    ],
                    ),  
                  ),
                  
                  _hr(),
              
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Address', style: TextStyle(color: Colors.white, fontSize: 16),),
                        SizedBox(height: 10,),
                        Text('0xddfsswwe131412412341d8dd2234', style: TextStyle(color: Colors.grey, fontSize: 12),),
                      ],
                    ),

                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: new InkWell(
                        onTap: () => doneAndBack(),
                        child: new Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50.0,
                          // width: ,
                          decoration: new BoxDecoration(
                            // color: Colors.blueAccent,
                            gradient: new LinearGradient(
                                colors: [Color(0xff194368), Color(0xff120e24)],
                                begin: new FractionalOffset(1.0, 0.0),
                                end: new FractionalOffset(1.0, 1.0),
                                //stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                            border: new Border.all(
                                color: Color(0xff28b8ff), width: 2.0),
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          child: new Center(
                            child: new Text(
                              'DONE',
                              style: new TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.white,
                                  fontFamily: 'LeagueGothic'),
                            ),
                          ),
                        ),
                      ),
                  ),   
                ],
              ),

          ],
        )
    )
    ) {  }
  }
  
  void transferToken()  async {
    
    BigInt a = convertEth(amount);
    String url = "https://##################";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final res = response.body;
      if (res != 'ERROR')
      {
        String url = "https://##################";
        final response = await http.get(url);

        setState(() {
          txHash = res;
        });
        if (isPopup)
        {
          Navigator.of(context).pop();
          isPopup = false;
          popupSuccess("Transaction Complete TxHash " + txHash);

        }
      }else {
        if (isPopup)
        {
          Navigator.of(context).pop();
          isPopup = false;
          popupSuccess("Transaction Error");
        }
      }
    }
  }

  void popupSuccess(String r) {
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Result"),
          content:  
          Container(
            // color: Colors.blue,
            height: 100,
            child:  Column(
              children: <Widget>[
                new Text(r),
                SizedBox(height: 20,),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showLoading() {
    isPopup = true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Loading"),
          content:  
          Container(
            height: 100,
            child:  Column(
              children: <Widget>[
                new Text("Please wait for transaction complete."),
                SizedBox(height: 20,),
                Center(child: new CircularProgressIndicator()),
              ],
            ),
          ),
          actions: <Widget>[
          ],
        );
      },
    );
    transferToken();

  }

  @override
  initState() {
    super.initState();
    getUser(userid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container (

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
          child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Container (
            child: Column (children: <Widget>[
              SizedBox(height: 40,),
              // MY APP BAR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: 
                    Row(
                      mainAxisAlignment:  MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                        'CONFIRM TRANSFER',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'LeagueGothic',
                            fontSize: 20.0),
                        ),
                        SizedBox(width: 32.0,)
                      ],
                    ),
                  ),
                  
                ],
              ),

              SizedBox(height: 60.0,),
              //Content Detail
              Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xff252738),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                                child:Column (
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row (children: <Widget>[
                                      Text('I WANT ', style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'LeagueGothic'),),
                                      Text('TO TRANSFER', style: TextStyle(color: Colors.blue, fontSize: 20,fontFamily: 'LeagueGothic'),),
                                    ],),
                                    SizedBox(height: 20,),
                                    Text('Select currentcy and enter amountyou want to buy', style: TextStyle(color: Colors.white, fontSize: 12,)),
                                    SizedBox(height: 20,),
                                    Row (
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                      Expanded(
                                        
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: new Border.all(color: Color(0xff49485b), width: 2.0),
                                            borderRadius: new BorderRadius.circular(5.0),
                                          ),
                                          child: 
                                            Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                
                                                Text(amount, style: TextStyle(color: Colors.white, fontSize: 14)),
                                                
                                              ],),
                                            )
                                        ),

                                      ),
                                      SizedBox(width: 10,),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: new Border.all(color: Color(0xff49485b), width: 2.0),
                                          borderRadius: new BorderRadius.circular(5.0),
                                        ),
                                        child: 
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                              
                                              Text('XSE', style: TextStyle(color: Colors.white, fontSize: 14)),
                                              
                                            ],),
                                          )
                                      ),
                                    ],),
                                    SizedBox(height: 20,),
                                    Row (children: <Widget>[
                                      Text('TRANSFER ', style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'LeagueGothic'),),
                                      Text('TO', style: TextStyle(color: Colors.blue, fontSize: 20,fontFamily: 'LeagueGothic'),),
                                    ],),
                                    SizedBox(height: 20,),

                                    Container(
                                        decoration: BoxDecoration(
                                          border: new Border.all(color: Color(0xff49485b), width: 2.0),
                                          borderRadius: new BorderRadius.circular(5.0),
                                        ),
                                        child: 
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                              
                                              Text(toWallet, style: TextStyle(color: Colors.white, fontSize: 12)),
                                              
                                            ],),
                                          )
                                      ),
                                  ],
                                  
                                )
                            ),
                            
                          ]
                        ),
                    ),

                    SizedBox(height: 30,),
                    
                    new InkWell(
                      onTap: () => _showLoading(),
                      child: new Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50.0,
                        // width: ,
                        decoration: new BoxDecoration(
                          // color: Colors.blueAccent,
                          gradient: new LinearGradient(
                              colors: [Color(0xff194368), Color(0xff120e24)],
                              begin: new FractionalOffset(1.0, 0.0),
                              end: new FractionalOffset(1.0, 1.0),
                              //stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          border: new Border.all(
                              color: Color(0xff28b8ff), width: 2.0),
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        child: new Center(
                          child: new Text(
                            'CONFIRM',
                            style: new TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontFamily: 'LeagueGothic'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    new InkWell(
                      onTap: () => Navigator.pop(context),
                      
                      child: new Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: new BoxDecoration(
                          gradient: new LinearGradient(colors: [Color(0xff2f0c33), Color(0xff5a094b)],
                            begin: new FractionalOffset(1.0,1.0),
                            end: new FractionalOffset(1.0, 0.0),
                            tileMode: TileMode.clamp
                          ),
                          border: new Border.all(color: Color(0xffff00a4), width: 2.0),
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        child: new Center(child: new Text('CANCEL', style: new TextStyle(fontSize: 24.0, color: Colors.white, fontFamily: 'LeagueGothic'),),),
                      ),
                    ),

            ],)
          )
        )
      ),
    );
  }
}