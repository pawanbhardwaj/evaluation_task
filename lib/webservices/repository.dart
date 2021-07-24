import 'package:evaluation_task/Model/response_from_api.dart';
import 'package:evaluation_task/webservices/api_provider.dart';

class Repository {
  final ApiProvider apiProvider = ApiProvider();
  Future<ResponseFromApi> getData() => apiProvider.getData();
}
