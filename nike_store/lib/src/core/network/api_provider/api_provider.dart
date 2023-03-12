import 'package:dio/dio.dart';

abstract class ApiProvider {
  Future<Response> get(String path);
}
