import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:expense_tracker/models/user_model.dart';
import 'package:expense_tracker/network/dio_client.dart';
import 'package:expense_tracker/models/login_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService{
  final String _url = 'https://dummyjson.com';
  var token;
  var dioClient = DioClient();

  // _getToken() async{
  //   const storage = FlutterSecureStorage();
  //   String? storedToken = await storage.read(key: 'token');

  //   if (storedToken != null) {
  //     token = storedToken.toString();
  //   } else {
  //     throw Exception("Token not found");
  //   }
  // }

  login(LoginModel data) async{
    try {
      var res = await dioClient.dio.post('/auth/login', data: data.toJson());
      const storage = FlutterSecureStorage();
      storage.write(key: 'token', value: res.data['accessToken']);
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

  getUser() async{
    try {
      var res = await dioClient.dio.get('/auth/me');
      return res.data;
    } catch (e) {
      if (e is DioException) {
        throw e.error ?? "Error";
      } else {
        throw Exception("Error");
      }
    }
  }

  // _setHeaders() => {
  //   'Content-type': 'application/json',
  //   'Accept': 'application/json',
  //   'Authorization': 'Bearer $token',
  // };
}

final AuthService authService = AuthService();