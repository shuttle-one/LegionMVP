import 'package:flutter/material.dart';

class WalletRow extends StatelessWidget {

  final String title;
  final String amount;

  WalletRow(this.title, this.amount);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0x00000000),
      ),
      child: 
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
              onTap: () {},
              child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset('assets/images/logo/eth.png', width: 24,),
                SizedBox(width: 10,),
                Text(title, style: TextStyle(fontSize: 14, color: Colors.lightBlue),),
                Expanded(
                  child: Row (
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(amount + ' ETH', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      SizedBox(width: 20,),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: Colors.white,
                      )
                    ],
                  ),
                )
                
              ],
            ),
          ),
        ),
        
    );
  }
}