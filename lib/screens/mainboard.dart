import 'package:flutter/material.dart';
import 'wallet/wallet_board.dart';
import 'buy.dart';
import 'sell.dart';
import 'offers.dart';
import 'account.dart';

class MainBoard extends StatefulWidget {
  final String userid;
  MainBoard(this.userid);

  @override
  _MainBoardState createState() => _MainBoardState(userid);
}

class _MainBoardState extends State<MainBoard> {
  String userid;
  _MainBoardState(this.userid);

  int _currentIndex = 0;

  List<Widget> _children = [
    WalletBoard("0"),
    BuyMain("0"),
    SellMain("0"),
    OffersMain(),
    Account("0")
  ];

  @override
  initState() {
    super.initState();
    _children = [
      WalletBoard(userid),
      BuyMain(userid),
      SellMain(userid),
      OffersMain(),
      Account(userid)
    ];
  }

  void onTabTapped(int index) {
    if (index !=3)
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    double iconSize = 42;
    
    return Scaffold(
      body: Container(
        child: _children[_currentIndex],
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Color(0xff191923), Color(0xff0f101b)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff282939),
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          BottomNavigationBarItem(
            // backgroundColor: Color(0xff282939),
            // icon: new Icon(Icons.home),
            icon: _currentIndex==0 ? new Image.asset('assets/images/icon/icon_wallet_open.png',width: iconSize,
                  height: iconSize,) 
                                  : new Image.asset('assets/images/icon/icon_wallet_close.png',width: iconSize,
                  height: iconSize,),
            // title: new Text('Wallet', style: TextStyle(color: Colors.white),),
            title: new Text('',style: TextStyle(fontSize: 1),),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xff282939),
            icon: _currentIndex==1 ? new Image.asset('assets/images/icon/icon_buy_open.png',width: iconSize,
                  height: iconSize,) : new Image.asset('assets/images/icon/icon_buy_close.png',width: iconSize,
                  height: iconSize,),
            title: new Text('',style: TextStyle(fontSize: 1),),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xff282939),
              icon: _currentIndex==2 ? new Image.asset('assets/images/icon/icon_sell_open.png',width: iconSize,
                  height: iconSize,) : new Image.asset('assets/images/icon/icon_sell_close.png',width: iconSize,
                  height: iconSize,),
              title: new Text('',style: TextStyle(fontSize: 1),),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xff282939),
              icon: _currentIndex==3 ? new Image.asset('assets/images/icon/icon_offers_open.png',width: iconSize,
                  height: iconSize,) : new Image.asset('assets/images/icon/icon_offers_close.png',width: iconSize,
                  height: iconSize,),
               title: new Text('',style: TextStyle(fontSize: 1),),
               ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xff282939),
              icon: _currentIndex==4 ? new Image.asset('assets/images/icon/icon_account_open.png',width: iconSize,
                  height: iconSize,) : new Image.asset('assets/images/icon/icon_account_close.png',width: iconSize,
                  height: iconSize,), 
              title: new Text('',style: TextStyle(fontSize: 1),),
          )
        ],
      ),
    );
  }
}
