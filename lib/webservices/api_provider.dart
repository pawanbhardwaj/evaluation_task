import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:evaluation_task/Model/response_from_api.dart';

import 'api_manager.dart';

class ApiProvider {
  final ApiManager apiManager = ApiManager();

  ///API to get response
  Future<ResponseFromApi> getData() async {
    try {
      Response response = await apiManager
          .dio()
          .post('/v3/6c89b268-64c4-4db1-8c71-1dc1924c7e4c');
      print(response.data);
      return responseFromApiFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      print('ERROR=> ${e.response?.data}');
      return e.response?.data;
    }
  }
}
