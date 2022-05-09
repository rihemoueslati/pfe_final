import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:forum_republique/utils/server_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class CallApi{
  final String _url = '${ServerConfig.serverAdressess}:8090/api/v1/auth/login';


  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }
  getData(apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken() ;
    return await http.get(
        Uri.parse(fullUrl),
        headers: _setHeaders()
    );
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }




}
