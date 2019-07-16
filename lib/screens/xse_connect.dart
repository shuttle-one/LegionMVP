import 'dart:async';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class XSE_Connect {

  String privateKey;
  String publicKey;
  String rpcURL = "https://##################";
  String xseAddress = "0x##################";

  XSE_Connect(this.privateKey,this.publicKey);

  void getETHAmount() async {
    var eth_amount = 0;
    var httpClient = new Client();
    Web3Client client = new Web3Client(this.rpcURL, httpClient);
    Future<EtherAmount> ethBalance = client.getBalance(EthereumAddress(publicKey));
      ethBalance.then((val) {
        eth_amount = val.getValueInUnit(EtherUnit.ether);
      });
  }

}