import 'package:flutter/material.dart';
import 'package:xse_wallet/screens/onboard/board.dart';
import 'package:xse_wallet/screens/onboard/dots_indicate.dart';
import '../../utils/design.dart';
import '../../utils/files.dart';
import '../mainboard.dart';
import 'dart:convert';
import '../../model/user.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  bool isLoading = true;

  final _controller = new PageController();
  final List<Widget> _pages = [
    BoardPage('Digital Transfers is now made','easy with ShuttleOne!','','assets/images/onboard/p01.png'),
    BoardPage('Pull all your wallets in one place to','transact with your friends!', '','assets/images/onboard/p02.png'),
    BoardPage('Your friends are not available?', 'ShuttleOne will ensure transactions','go thru!','assets/images/onboard/p03.png'),
    BoardPage('Be notified of transfers from your', 'friends instantly!','','assets/images/onboard/p04.png'),
  ];
  int page = 0;

  Color gradientStart = Colors.deepPurple[100];
  Color gradienEnd = Colors.purple[500];
  MyFiles myFiles = new MyFiles();

  @override
  void initState() {
    super.initState();
    
    myFiles.readCounter().then((v) {
      if (v!=null && v!='')
      {
        final map = jsonDecode(v);
        Future <User> user = User.getUserLogin(map['u'], map['p']).then((v) {
          setState(() {
            isLoading = false;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainBoard(v.id),
              ),
            );

          });
        });

      }else {
        setState(() {
          isLoading = false;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    if (isLoading)
      return Container(
        child: 
          Center(
            child: CircularProgressIndicator()
          )
      );
    else 
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: new Stack(
        children: <Widget>[
          new Positioned.fill(
            child: new PageView.builder(
              physics: new AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemCount: _pages.length,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
              onPageChanged: (int p){
                setState(() {
                  page = p;
                });
              },
            ),
          ),
          
          new Positioned(
            bottom: 10.0,
            left: 0.0,
            right: 0.0,
            
            child: new SafeArea(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DotsIndicator(
                      controller: _controller,
                      itemCount: _pages.length,
                      onPageSelected: (int page) {
                        _controller.animateToPage(
                          page,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Container(
                        width: 240.0,
                        height: 50.0,
                        decoration: Design.ButtonBlueDecorateBox(),
                        child: new Material(
                          child: MaterialButton(
                            child: Text('SIGN UP',
                              style: Design.fontStyle(24.0, Colors.white),
                            ),
                            onPressed: (){Navigator.pushNamed(context, '/signup');},
                          ),
                          color: Colors.transparent,
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      SizedBox(height: 10),
                      new Container(
                        width: 240.0,
                        height: 50.0,
                        decoration: Design.ButtonPinkDecorateBox(),
                        child: new Material(
                          child: MaterialButton(
                            child: Text('LOG IN',
                              style: Design.fontStyle(24.0, Colors.white),
                            ),
                            onPressed: (){Navigator.pushNamed(context, '/login');},
                            highlightColor: Colors.white30,
                            splashColor: Colors.white30,
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
  
}
