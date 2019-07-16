class Tran {
  String id;
  String txHash;
  String tx;
  String from_Wallet;
  String to_wallet;
  String amount;
  String updatedate;

  Tran(this.id,this.txHash,this.from_Wallet,this.to_wallet,this.amount,this.tx);
  
  Tran.fromJson(Map<String,dynamic> json) {

    id = json['id'];
    txHash = json['txhash'];
    tx = json['tx'];
    from_Wallet = json['from_wallet'];
    to_wallet = json['to_wallet'];
    amount = json['amount'];
    updatedate = json['updatedate'];
  }
}