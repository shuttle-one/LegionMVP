import 'package:flutter/material.dart';
import 'transaction_row.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user.dart';
import '../model/tran.dart';

class Transaction extends StatefulWidget {

  final User _my;
  Transaction(this._my);

  @override
  _TransactionState createState() => _TransactionState(_my);
}

class _TransactionState extends State<Transaction> {
  User my;
  _TransactionState(this.my);

  void getTransaction()  async {
    
    String url = "https://####################";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List res = json.decode(response.body);
      List<Tran> list = res.map((val) =>  Tran.fromJson(val)).toList();
      
      if (this.mounted) {
        setState(() {
          lists = list;
        });
      }
    }
  }
      
  List<Tran> lists = [Tran('','','','','','')];

  @override
  void initState() {
    super.initState();
    getTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff11121d),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
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
                    Text(
                      'MYWALLET',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'LeagueGothic',
                          fontSize: 20.0),
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ],
                ),

                

                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text('Last transactions', style: TextStyle(color: Colors.white),),
                      Expanded(
                        
                        child: 
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text('Full history', style: TextStyle(color: Colors.blue), textAlign: TextAlign.right,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                
                new Expanded(
                    child: 
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: 
                      // TransactionRow()
                          new ListView.builder
                          (
                            padding: EdgeInsets.all(0.0),
                            itemCount: lists.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return new TransactionRow(lists[index],my.publicKey);
                            }
                          )
                      
                    )
                  
                )
                
              ],
            ),
          ),
        ));
  }
}
