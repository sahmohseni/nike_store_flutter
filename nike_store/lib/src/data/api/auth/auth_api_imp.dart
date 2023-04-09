import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/core/network/api_provider/api_provider.dart';
import 'package:nike_store/src/data/api/auth/auth_api.dart';
import 'package:nike_store/src/domain/model/api_response/api_response.dart';

class AuthApiImp extends AuthApi {
  @override
  Future<ApiResponse> login(String userName, String passWord) async {
    final loginResponse = await KiwiContainer()
        .resolve<ApiProvider>()
        .post('http://expertdevelopers.ir/api/v1/auth/token', bodyParameter: {
      'grant_type': 'password',
      'client_id': 2,
      'client_secret': 'kyj1c9sVcksqGU4scMX7nLDalkjp2WoqQEf8PKAC',
      'username': userName,
      'password': passWord
    });
    return ApiResponse.fromResponse(response: loginResponse);
  }

  @override
  Future<ApiResponse> refreshToken(String token) async {
    final refreshTokenResponse = await KiwiContainer()
        .resolve<ApiProvider>()
        .post('http://expertdevelopers.ir/api/v1/auth/token', bodyParameter: {
      'grant_type': 'refresh_token',
      'refresh_token': token,
      'client_id': 2,
      'client_secret': 'kyj1c9sVcksqGU4scMX7nLDalkjp2WoqQEf8PKAC'
    });
    return ApiResponse.fromResponse(response: refreshTokenResponse);
  }

  @override
  Future<ApiResponse> signUp(String userName, String passWord) async {
    final signUpResponse = await KiwiContainer().resolve<ApiProvider>().post(
        'http://expertdevelopers.ir/api/v1/user/register',
        bodyParameter: {'email': userName, 'password': passWord});
    return ApiResponse.fromResponse(response: signUpResponse);
  }
}
