import 'package:dio/dio.dart';
import 'package:expense_tracker/interceptors/auth_interceptor.dart';

class DioClient {
  static const String _baseUrl = "https://dummyjson.com";

  DioClient() {
    addInterceptor(LogInterceptor());
  }

  final Dio dio = Dio(
    BaseOptions(baseUrl: _baseUrl),
  );

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(AuthInterceptor(dio: dio));
    dio.interceptors.add(interceptor);
  }
}