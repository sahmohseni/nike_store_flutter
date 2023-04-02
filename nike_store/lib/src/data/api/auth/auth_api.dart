import 'package:nike_store/src/core/network/base_api.dart';
import 'package:nike_store/src/domain/model/api_response/api_response.dart';

abstract class AuthApi extends BaseApi {
  Future<ApiResponse> login(String userName, String passWord);
  Future<ApiResponse> signUp(String userName, String passWord);
  Future<ApiResponse> refreshToken(String token);
}
