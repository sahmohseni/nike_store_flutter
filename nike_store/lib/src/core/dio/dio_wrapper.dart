import 'package:dio/dio.dart';
import 'package:nike_store/src/domain/repository/auth/auth_repository_imp.dart';

class DioWrapper {
  static Dio provide() {
    final dio = Dio();
    dio.interceptors.add(_getResponseInterceptor());
    return dio;
  }

  static QueuedInterceptor _getResponseInterceptor() {
    return QueuedInterceptorsWrapper(onRequest: _onRequest);
  }

  static void _onRequest(
      RequestOptions options, RequestInterceptorHandler handler) {
    final authInfo = AuthRepositoryImp.authChangeNotifier.value;
    if (authInfo != null || authInfo!.accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${authInfo.accessToken}';
    }
    return handler.next(options);
  }
}
