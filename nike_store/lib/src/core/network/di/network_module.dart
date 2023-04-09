import 'package:dio/dio.dart';
import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/core/dio/dio_wrapper.dart';
import 'package:nike_store/src/core/network/api_provider/api_provider.dart';
import 'package:nike_store/src/core/network/api_provider/api_provider_imp.dart';

void networkInjector() {
  KiwiContainer().registerFactory<Dio>((container) => DioWrapper.provide());
  KiwiContainer().registerFactory<ApiProvider>((container) => ApiProviderImp());
}
