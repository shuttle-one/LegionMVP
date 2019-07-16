import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/user.dart';

class FetchHTTP {

  Future<User> fetchLoginUSer(String url) async {
    User user = User('','');//,'','');
    final response = await http.get(url);
    final map = json.decode(response.body);

    return user;
  }
}