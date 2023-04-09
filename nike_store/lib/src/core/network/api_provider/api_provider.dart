import 'package:dio/dio.dart';

abstract class ApiProvider {
  Future<Response> get(String path);
  Future<Response> post(String path,
      {dynamic bodyParameter, Map<String, dynamic>? headerParameter});
}
