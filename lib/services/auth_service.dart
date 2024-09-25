import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:expense_tracker/network/dio_client.dart';
import 'package:expense_tracker/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService{
  final String _url = 'https://dummyjson.com';
  var token;
  

  _getToken() async{
    const storage = FlutterSecureStorage();
    String? storedToken = await storage.read(key: 'token');

    if (storedToken != null) {
      token = jsonDecode(storedToken)['token'];
    }
  }

  login(LoginModel data) async{
    try {
      var dioClient = DioClient();
      var res = await dioClient.dio.post('/auth/login', data: data.toJson());
      const storage = FlutterSecureStorage();
      storage.write(key: 'token', value: json.encode(res.data['accessToken']));
    }  catch (e) {
      if (e is DioException) {
        throw e.error ?? "Error";
      } else {
        throw Exception("Error");
      }
    }
  }

  logout() async{
    const storage = FlutterSecureStorage();
    storage.delete(key: 'token');
    storage.delete(key: 'user');
  }

  getData(apiURL) async{
    var fullUrl = _url + apiURL;
    await _getToken();
    return await http.get(
      fullUrl as Uri,
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
}

final AuthService authService = AuthService();