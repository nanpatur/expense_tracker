import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Network{
  final String _url = 'https://dummyjson.com';
  var token;

  _getToken() async{
    const storage = FlutterSecureStorage();
    String? storedToken = await storage.read(key: 'token');

    if (storedToken != null) {
      token = jsonDecode(storedToken)['token'];
    }
  }

  login(data) async{
    Uri fullUrl = Uri.parse('$_url/auth/login');
    var res = await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders()
    );

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      const storage = FlutterSecureStorage();
      storage.write(key: 'token', value: json.encode(body['token']));
      storage.write(key: 'user', value: json.encode(body['user']));
    }
    return res;
  }

  logout() async{
    const storage = FlutterSecureStorage();
    storage.delete(key: 'token');
    storage.delete(key: 'user');
  }

  auth(data) async{
    Uri fullUrl = Uri.parse('$_url/auth');
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders()
    );
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