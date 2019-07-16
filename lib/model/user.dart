import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/strings.dart';

class User {
  String id;
  String username;
  String privateKey;
  String publicKey;

  String rpcURL = "https://kovan.infura.io/v3/09cc668061974577a6f11a2819588411";
  String xseAddress = "0x0265571469FE07eAC20101f1847038609CB392eB";

  String xseABI = '[{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_spender","type":"address"},{"name":"_value","type":"uint256"}],"name":"approve","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_owner","type":"address"}],"name":"removeOwner","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"totalSupply","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_from","type":"address"},{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transferFrom","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"_owner","type":"address"}],"name":"isOwner","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"newOwner","type":"address"},{"name":"newOwnerName","type":"string"}],"name":"addOwner","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"_walletAddress","type":"address"}],"name":"balanceOf","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transfer","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"ownerAddr","type":"address"}],"name":"getOwnerName","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_from","type":"address"},{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"intTransfer","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"_owner","type":"address"},{"name":"_spender","type":"address"}],"name":"allowance","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"newOwner","type":"address"},{"name":"newOwnerName","type":"string"}],"name":"transferOwnership","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"name":"previousOwner","type":"address"},{"indexed":true,"name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"newOwner","type":"address"},{"indexed":false,"name":"name","type":"string"}],"name":"AddOwner","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"owner","type":"address"}],"name":"RemoveOwner","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"from","type":"address"},{"indexed":true,"name":"to","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"Transfer","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"owner","type":"address"},{"indexed":true,"name":"spender","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"Approval","type":"event"}]';

  User(this.id,this.username,{this.privateKey,this.publicKey});

  static Future<User> getUser(String id) async {
    User u = null;
    String url = "http://natee.network/xse_wallet/api/user.php?id=" + id;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      // print(map['code']);
      if (map['code']=='0')
      {
        final user = map['data'][0];
        // print(user['id']);
        u = new User(user['id'],user['username'])//,user['privatekey'],user['publickey']);
        ..privateKey = user['privatekey']
        ..publicKey = user['publickey'];
          
      }else {
        // print(response);
      }
      return u;
    } 
  }

  static Future<User> getUserLogin(String username, String password) async {
    User user = null;
    String url = Strings.context_url + Strings.login_file + "?u=$username&p=$password";

    print("Url = " + url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final map = json.decode(response.body);

      if (map['code']=='0')
      {
        final data = map['data'][0];
        user = new User(data['id'],data['username']); //,data['privatekey'],data['publickey']);
        
      }
    }

    return user;
  }

}