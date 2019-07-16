import 'package:flutter/material.dart';
import 'screens/signin/signin.dart';
import 'screens/signin/login.dart';
import 'package:flutter/services.dart';
import 'screens/signin/signup.dart';
import 'screens/wallet/pintest.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XSE Wallet',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // fontFamily: 'LeagueGothic'
      ),
      //home: SignIn(), //MyHomePage(title: 'Flutter Demo Home Page'),

      initialRoute: '/',
      routes: {
        // When we navigate to the "/" route, build the FirstScreen Widget
        '/': (context) => SignIn(),
        // When we navigate to the "/second" route, build the SecondScreen Widget
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/pintest': (context) => PinScreen(),
        // '/mainboard': (context) => MainBoard(),
      },

    );
  }
}