import 'package:flutter/material.dart';
import 'package:xse_wallet/model/wallet.dart';
import '../transaction.dart';
import 'wallet_row.dart';

class WalletCard extends StatelessWidget {

  final String xseAmount;
  final List<MyWallet> wallets;
  double allAmount = 0.0;

  WalletCard(this.xseAmount, this.wallets);

  List<Widget> createWalletRow() {
    return new List<Widget>.generate(wallets.length, (int index) {
      return WalletRow(wallets[index].name, wallets[index].amount);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff252738),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
        
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/images/logo/eth.png', width: 28,),
                      SizedBox(width: 10,),
                      Text('Ethereum', style: TextStyle(color: Colors.white, fontSize: 18),),
                      SizedBox(width: 10,),
                      Text('ETH', style: TextStyle(color: Color(0xff8d8e93), fontSize: 18),),
                      
                    ],
                  ),
                ),
                
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff393c50),
                    borderRadius: new BorderRadius.only(
                    bottomLeft:  const  Radius.circular(12.0),
                    bottomRight: const  Radius.circular(12.0)),
                  ),
                  child: new ExpansionTile(

                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(xseAmount +' ETH', style: TextStyle(color: Colors.white, fontSize: 16),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text('3.778.23 TUSD/ETH', style: TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.right,),
                            Text('~0.35 TUSD', style: TextStyle(color: Color(0xff9d9eab), fontSize: 12), textAlign: TextAlign.right),
                          ],
                        )
                      ], 
                      
                    ),
                    children: createWalletRow(), 
                  
                  ),
                ),
                
            ],),
            
          ),

        ],
      ),
    );
  }
}