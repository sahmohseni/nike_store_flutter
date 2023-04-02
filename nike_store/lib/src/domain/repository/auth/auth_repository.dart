import 'package:nike_store/src/domain/model/auth/auth_info.dart';

abstract class AuthRepository {
  Future<AuthInfo> login(String userName, String passWord);
  Future<AuthInfo> signUp(String userName, String passWord);
  Future<AuthInfo> refreshToken(String token);
  Future<void> signOut();
}
