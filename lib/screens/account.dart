import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class Account extends StatefulWidget {
  final String _userid;
  Account(this._userid);

  @override
  _AccountState createState() => _AccountState(_userid);
}

class _AccountState extends State<Account> {

  String link = 'http://';
  String amount = 'x,xxx';
  String userid;

  _AccountState(this.userid);

  _fetchData() async {
    String url = "https://#################";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      setState(() {
        link = map['link'];
        amount = map['amount'];
      });
    }
  }

  _launchURL() async {
    String url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
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
              padding: const EdgeInsets.all(12.0),
              child: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: 
                  Column(
                    children: <Widget>[
                      SizedBox(height: 40,),
                      Image.asset('assets/images/s_logo.png', width: 200,),
                      SizedBox(height: 40,),
                      Text('Send your personal invitation link:', style: TextStyle(color: Colors.white, fontSize: 18),),
                      SizedBox(height: 10,),

                       new FlatButton(
                        child: new Text(
                          link,
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                        onPressed: () {
                          _launchURL();
                        }
                       ),
                       
                      SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: <Widget>[
                            Text('For every friend who signs up, we\'ll bump you up the queue',
                            style: TextStyle(color: Colors.grey, fontSize: 16), 
                            textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text('by ${amount} places', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
                          ], 
                        ),
                      ),
                      SizedBox(height: 40,),
                      new MaterialButton( 
                          height: 40.0, 
                          minWidth: MediaQuery.of(context).size.width * 0.8, 
                          color: Color(0xffeb008d),
                          textColor: Colors.white,
                          child: new Text("Invite friends",style: TextStyle(fontSize: 18),), 
                          onPressed: () => {}, 
                          splashColor: Color(0xffeb008d),
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                          ),
                        SizedBox(height: 10,)
                    ]
                  )
              )
          
          )
        )
      )
    );
  }
}