import 'package:dio/dio.dart';

class NetworkService {
  Future onReady;
  Dio dio;

  factory NetworkService() => NetworkService._();
  NetworkService._() {
    onReady = Future(() async {
      String baseUrl = "https://jsonplaceholder.typicode.com/";

      var headers = {
        'content-Type': 'application/json',
      };
      dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 20000,
        receiveTimeout: 20000,
        headers: headers,
        responseType: ResponseType.json,
      ));

      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    });
  }
}
