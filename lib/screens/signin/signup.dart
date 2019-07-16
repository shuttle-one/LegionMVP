import 'package:flutter/material.dart';
import '../mainboard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/strings.dart';
import '../../utils/design.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();

  String userid;

  _fetchData(String u, String p) async {
    String url = "https://################";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      if (map['code']==0)
      {
        final msg = map['msg'];
        _showDialog('Success', msg);
      } else {
        String msg = map['msg'];
        _showDialog('Error', msg);
      }
    }
    
  }

  @override
  void dispose() {
    
    usernameController.dispose();
    passwordController.dispose();
    repasswordController.dispose();
    super.dispose();
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
              },
            ),
          ],
        );
      },
    );
  }

  void checkRegister() {

    var username = usernameController.text;
    var password = passwordController.text;
    var repassword = repasswordController.text;

    if (username=='' || password=='' || repassword==''){
      _showDialog('Register Error', 'Please input all data');
    }
    else 
    if (password != repassword)
    {
      _showDialog('Register Error', 'Please check your password');
    }else {
      _fetchData(username, password);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
                  
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    BackButton(color: Colors.white,),
                    
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                        children: <Widget>[
                        Text(
                          'SIGN UP',
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
                        Text(
                          'Confirm your password',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: repasswordController,
                            obscureText: true,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Colors.red)))),

                        SizedBox(
                          height: 40,
                        ),

                        Center(
                          child: Container(
                            
                            width: 300.0,
                            height: 50.0,
                            decoration: Design.ButtonBlueDecorateBox(),
                            child: new Material(
                              child: MaterialButton(
                                child: Text('REGISTER',
                                  style: Design.fontStyle(24.0, Colors.white),
                                ),
                                onPressed: (){checkRegister();},
                              ),
                              color: Colors.transparent,
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        
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
