import 'package:dio/dio.dart';
import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/core/network/api_provider/api_provider.dart';
import 'package:nike_store/src/core/network/api_provider/api_provider_imp.dart';

void networkInjector() {
  KiwiContainer().registerFactory<Dio>((container) => Dio());
  KiwiContainer().registerFactory<ApiProvider>((container) => ApiProviderImp());
}
