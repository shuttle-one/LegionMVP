import 'package:flutter/material.dart';
import '../model/tran.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionRow extends StatelessWidget {

  final Tran t;
  final String myWallet;
  TransactionRow(this.t,this.myWallet);
  
  _launchURL() async {
    String url = "https://#################";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[ 
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row (
            children: <Widget>[
              (t.from_Wallet == myWallet) ? 
                Image.asset('assets/images/icon/btn_up.png', width: 32,) : 
                Image.asset('assets/images/icon/btn_down.png', width: 32,),

              SizedBox(width: 10,),
              Column (    
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(t.amount + ' XSE', style: TextStyle(color: Colors.white)),
                  Text(t.tx + '..', style: TextStyle(color: Colors.grey)),
                  // Text('23.11 4:10PM', style: TextStyle(color: Colors.grey)),
              ],),
              Expanded (child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                    iconSize: 18,
                    icon: Icon(Icons.arrow_forward_ios),
                    color: Colors.white,
                    onPressed: () { _launchURL(); },
                  ),
                  ],
                ) 
                
              )
              
            ],
          ),
        ),
        // SizedBox( height: 5,),
        SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          height: 0.3,
          child: const DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.grey
            ),
          ),
        ),
      ]
    );
  }
}
