import 'package:flutter/material.dart';
import 'buy_review.dart';
import '../utils/design.dart';

class BuyMain extends StatefulWidget {
  final String userid;
  BuyMain(this.userid);
  @override
  _BuyMainState createState() => _BuyMainState(userid);
}

class _BuyMainState extends State<BuyMain> {

  String userid;
  _BuyMainState(this.userid);

  String toWallet = 'xxxx';
  String token_name = 'XSE';

  List<String> token_names = ['XSE','BTC','ETH'];
  List<String> wallets = ['W01','W02'];

  final amountController = TextEditingController();
  final receiveWallerController = TextEditingController();

  checkValidate () {
    _push();
  }

  void _push() {
    String amount = amountController.text;

    if (isNumeric(amount)) 
    {
      double b = double.parse(amount) * 1000000;
      BigInt a = BigInt.from(b);
      a = a * BigInt.from(1000000000000);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BuyReview(
          userid,
          amountController.text,
          receiveWallerController.text
        ),
      ));
    }
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  @override
  initState() {
    super.initState();
    if (userid=="1")
      toWallet=wallets[1];
    else 
      toWallet = wallets[0];

    receiveWallerController.text = toWallet;
    // receiveWallerController = new TextEditingController(text: 'Initial value');
  }

  void changeTokenName(String selectedCurrency) {
  setState(() {
    token_name = selectedCurrency;
  });
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
                //begin: new FractionalOffset(0.0,0.5),
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter, //new FractionalOffset(0.5, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),

          child: 
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50,),
                    Text(
                      'TRANSFER CRYPTOCURRENCY',
                      style: Design.fontStyle(22.0, Colors.white)
                    ),
                    SizedBox(height: 40,),
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
                              padding: const EdgeInsets.all(25.0),
                                child:Column (
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row (children: <Widget>[
                                      Text('I WANT ', style: Design.fontStyle(20, Colors.white)),// TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'LeagueGothic'),),
                                      Text('TO TRANSFER', style: Design.fontStyle(20, Colors.blue)),//TextStyle(color: Colors.blue, fontSize: 20,fontFamily: 'LeagueGothic'),),
                                    ],),
                                    SizedBox(height: 20,),
                                    Text('Select currentcy and enter amountyou want to buy', style: TextStyle(color: Colors.white, fontSize: 12,)),
                                    SizedBox(height: 20,),
                                    Row (
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                      Expanded(
                                        
                                        child: TextFormField(
                                        controller: amountController,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        keyboardType: TextInputType.number,
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

                                      ),
                                      SizedBox(width: 10,),
                                      Container(
                                        width: 100,
                                        height: 60,
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

                                              Text('XSE', style: TextStyle(color: Colors.white, fontSize: 18)),
                                              Icon(Icons.arrow_drop_down, color: Colors.white,),

                                            ],),
                                          )
                                      ),
                                    ],),
                                    SizedBox(height: 20,),
                                    Row (children: <Widget>[
                                      Text('TRANSFER ', style: Design.fontStyle(20, Colors.white)),//TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'LeagueGothic'),),
                                      Text('TO', style: Design.fontStyle(20, Colors.blue)),//TextStyle(color: Colors.blue, fontSize: 20,fontFamily: 'LeagueGothic'),),
                                    ],),
                                    SizedBox(height: 20,),
                                    TextFormField(
                                        // initialValue: "STEST",
                                        controller: receiveWallerController,
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

                                  ],
                                )
                            )
                          ]
                        ),
                    ),
                    SizedBox(height: 30,),
                    
                    new InkWell(
                      onTap: () => checkValidate(),
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
                            'NEXT',
                            style: Design.fontStyle(24.0, Colors.white),
                          ),
                        ),
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