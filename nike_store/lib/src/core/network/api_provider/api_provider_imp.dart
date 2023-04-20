import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/core/network/api_provider/api_provider.dart';

class ApiProviderImp extends ApiProvider {
  @override
  Future<Response> get(String path) async {
    final dio = KiwiContainer().resolve<Dio>();
    final getResponse = await dio.get(path);
    return getResponse;
  }

  @override
  Future<Response> post(String path,
      {dynamic bodyParameter, dynamic? headerParameter}) async {
    final dio = KiwiContainer().resolve<Dio>();
    final postResponse = await dio.post(path, data: bodyParameter);
    return postResponse;
  }
}
