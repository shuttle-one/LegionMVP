import 'package:flutter/material.dart';
import 'wallet_card.dart';
import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web3dart/src/utils/numbers.dart' as numbers;
import '../../utils/design.dart';
import '../../utils/strings.dart';
import '../../model/wallet.dart';
import 'wallet_add.dart';


class WalletBoard extends StatefulWidget {
  final String userid;
  WalletBoard(this.userid);

  @override
  _WalletBoardState createState() => _WalletBoardState(userid);
}

class _WalletBoardState extends State<WalletBoard> {
  String xseAmount = 'xxx';
  String userid = "";
  _WalletBoardState(this.userid);

  bool isLoading = true;

  List<MyWallet> wallets = [];

  getUser(String id) async {
    String url = "https://#################";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      if (map.length > 0)
      {
        for(int i=0;i<map.length;i++) {
          MyWallet w = new MyWallet(map[i]['wallet_name'], map[i]['wallet_address']);
          wallets.add(w);
          w.amount = "";
        }
      }

      if (this.mounted){
        double allAmount = 0.0;
        for (var w in wallets) {
          url = "https://##################";
          final walletResponse = await http.get(url);
          if (walletResponse.statusCode == 200) {
            final String xse_amount = walletResponse.body;
            w.amount = xse_amount.substring(0,(xse_amount.length-18));
            allAmount += double.parse(w.amount);
          }
        }
        setState(() {
          xseAmount = allAmount.toString();
          isLoading = false;
        });
      }
    } 
  }

  _refresh() {
    getUser(userid);
  }

  @override
  initState() {
    super.initState();
    getUser(userid);
  }

  @override
  Widget build(BuildContext context) {
    return
     new WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    alignment: Alignment.topRight,
                    image: new AssetImage("assets/images/bg_line.png"),
                    fit: BoxFit.fitWidth,
                  ),
                  gradient: new LinearGradient(
                      colors: [Color(0xff191923), Color(0xff0f101b)],
                      begin: Alignment.topCenter,
                      end: Alignment
                          .bottomCenter,
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/images/s_logo.png",
                              width: 50,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "YOUR",
                                  style: Design.fontStyle(28, Color(0xffff00a4)) 
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      ".",
                                      style: Design.fontStyle(28, Color(0xffff00a4)) 
                                    ),
                                    Text(
                                      "WALLETS",
                                      style: Design.fontStyle(28, Color(0xff00b2e2)) 
                                    )
                                  ],
                                )
                              ],
                            ),
                            new Expanded(
                              child: Row(
                                children: <Widget>[
                                  InkWell(child: 
                                    Image.asset(
                                      "assets/images/btn_plus.png",
                                      width: 36,
                                    ),
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => WalletAdd(userid)),
                                    ),
                                  ),

                                ],
                                mainAxisAlignment: MainAxisAlignment.end,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),

                        isLoading ? 
                          CircularProgressIndicator() : 
                          WalletCard(xseAmount, wallets),

                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'next',
                          style: TextStyle(color: Colors.black),
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
                                onPressed: (){
                                  Navigator.pushNamed(context, '/pintest');
                                },
                              ),
                              color: Colors.transparent,
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ))));
  }
}
