import 'package:dio/dio.dart';

class ApiManager {
  Dio dio() {
    Dio dio = Dio(
      new BaseOptions(
        baseUrl: 'https://run.mocky.io',
      ),
    );

    return dio;
  }
}
