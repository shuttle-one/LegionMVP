import 'package:flutter/material.dart';
import '../mainboard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/strings.dart';
import '../../utils/design.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../utils/files.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isRemember = false;
  
  String userid;
  
  _fetchData(String u, String p) async {
    String url = Strings.context_url + "/login.php?u="+ u +"&p=" + p;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
      final map = json.decode(response.body);
      
      if (map['code']=='0')
      {
        final user = map['data'][0];
        userid = user['id'];


        MyFiles f = new MyFiles();
        if (isRemember) {
          String acc = "{\"u\":\"" + u + "\",\"p\":\""+ p+"\",\"id\":\"" + userid + "\"}";
          f.writeCounter(acc).then((v) {
            _gotoWallet(userid);
          });

          // f.readCounter().then((v) { 
          //   final a = json.decode(v);
          //   print(a["u"]);
          // });
        } else {
          f.writeCounter("").then((v) {
            _gotoWallet(userid);
          });
        }
        
        
      } else {
        _showDialog("Error", "Username / Password not correct");
      }
    }else {
      // print(response);
      _showDialog("Error", "Server Error");
    }
    
  }

  _gotoWallet(String userid) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainBoard(userid),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showDialog(String title, String detail) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(detail),
          actions: <Widget>[
            // new Center(child: new CircularProgressIndicator()),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void checkLogin() {

    var username = usernameController.text;
    var password = passwordController.text;

    _fetchData(username, password);

    // _fetchData(username, password);
    // Navigator.pushReplacementNamed(context, '/mainboard');
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: 
        Design.getBGDecoratedBox(),
        child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    BackButton(color: Colors.white,),
                    
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                        children: <Widget>[
                        Text(
                          'LOGIN',
                          style: Design.fontStyle(32, Colors.white)
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Enter your username or e-mail',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: usernameController,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Colors.red)))),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Enter your password',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Colors.red)))),

                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Forget password?',
                              style: TextStyle(color: Colors.blue, fontSize: 14),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                        Theme(
                            data: ThemeData(unselectedWidgetColor : Colors.grey),
                            child: 
                            Row(
                              children: <Widget>[
                                new Checkbox(
                                  onChanged: (bool val) {
                                    setState(() {
                                      isRemember = !isRemember;
                                    });
                                  },
                                  value: isRemember,
                                  activeColor: isRemember ? Colors.purple: Colors.grey,
                                  // checkColor: Colors.grey,
                                ),
                                Text('Remember password', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                        ),
                        SizedBox(
                          height: 60,
                        ),

                        Center(
                          child: Container(
                            
                            width: 300.0,
                            height: 50.0,
                            decoration: Design.ButtonPinkDecorateBox(),
                            child: new Material(
                              child: MaterialButton(
                                child: Text('LOG IN',
                                  style: Design.fontStyle(24.0, Colors.white),
                                ),
                                onPressed: (){checkLogin();},
                                //highlightColor: Colors.orange.withOpacity(0.5),
                                //splashColor: Colors.orange.withOpacity(0.5),
                              ),
                              color: Colors.transparent,
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        

                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Text('I don\'t have an account yet',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 12))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
