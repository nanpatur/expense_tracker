import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor({
    required this.dio,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
      const storage = FlutterSecureStorage();
    var token = (await storage.read(key: 'token'));
    options.headers.addAll({
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      return handler
          .resolve(await dio.fetch(err.requestOptions));
    }

    return handler.reject(DioException(
      requestOptions: err.requestOptions,
      error: err.response,
    ));
  }
}
