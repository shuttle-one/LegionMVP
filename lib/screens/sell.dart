import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../utils/strings.dart';

class SellMain extends StatefulWidget {
  final String userid;

  SellMain(this.userid);
  @override
  _SellMainState createState() => _SellMainState(userid);
}

class _SellMainState extends State<SellMain> {

  String userid;
  _SellMainState(this.userid);

  String wallet = '';
  Timer timer ;

  void _showToast(BuildContext context, amount) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        content:
          Container(
            height: 74,
            child: Column(
                
                children: <Widget>[
                Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('New receive transfer',),
                    new InkWell(
                      onTap: () => scaffold.hideCurrentSnackBar(),
                      child: new Container(
                        //width: 100.0,
                        height: 20.0,
                        child: Text('X'),
                      )
                    )
                  ]
                ),
                SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                  Image.asset('assets/images/logo/token.png'),
                  SizedBox( width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Text('Receiver'),
                    Text('23.11 4:10PM')
                  ],),
                  Expanded(
                    
                    child: Text(amount + ' XSE', textAlign: TextAlign.right,),
                  )
                  
                ])
              ],
            ),
          ),
          
      ),
    );
  }

  _fetchData() async {
    String url = Strings.context_url + "RECEIVE";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      if (map['code']=='0')
      {
        final user = map['data'][0];
        setState(() {
          this.wallet = user['wallet'];
        });
      }
    }
  }

  checkReceive() async {

    String url = Strings.context_url + "CHECK_";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List map = json.decode(response.body);
      if (map.length > 0)
      {
        _showToast(context, map[0]['amount']);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  initState() {
    super.initState();
    _fetchData();

    timer = Timer.periodic(new Duration(seconds: 3), (timer) {
      checkReceive();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: 
      Container(
          
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Color(0xff191923), Color(0xff0f101b)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter, //new FractionalOffset(0.5, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),

        child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50,),
                    Text(
                      'RECEIVE CRYPTOCURRENCY',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'LeagueGothic',
                          fontSize: 20.0),
                    ),
                    SizedBox(height: 60,),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        // padding: EdgeInsets.symmetric(vertical: 14.0,horizontal: 24.0),
                        decoration: BoxDecoration(
                          //color: themeColor,
                          color: Color(0xff252738),
                          borderRadius: BorderRadius.circular(5.0),
                          // boxShadow: [BoxShadow(color: Colors.pink.shade100,blurRadius: 200.0,spreadRadius: 0.1,offset: Offset(0.0, 10.0)),BoxShadow(color: Colors.white,blurRadius: 300.0,spreadRadius: 10.5)],
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                                child:Column (
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row (children: <Widget>[
                                      Text('RECEIVE ', style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'LeagueGothic'),),
                                      Text('TRANSFER', style: TextStyle(color: Colors.blue, fontSize: 20,fontFamily: 'LeagueGothic'),),
                                    ],),
                                    SizedBox(height: 20,),
                                    Text('Address', style: TextStyle(color: Colors.white, fontSize: 14),),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: 
                                        Container (
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                          border: new Border.all(color: Color(0xff49485b), width: 2.0),
                                          borderRadius: new BorderRadius.circular(5.0),
                                        ),
                                         child: new Text (this.wallet,
                                                  textAlign: TextAlign.left,
                                                  softWrap: true,
                                                  style: TextStyle(color: Colors.grey),),
                                        ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text('Scan QRCode', style: TextStyle(color: Colors.white, fontSize: 14)),
                                    SizedBox(height: 10,),
                                    Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset('assets/images/qrcode.png', width: 120,)
                                      ],),
                                    )

                                  ]
                                ),
                            ),

                            
                          ]
                        )
                    )
                  ]
                )
              )
            )
        )
      )
      
    );
  }
}