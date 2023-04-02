import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/data/api/auth/auth_api.dart';
import 'package:nike_store/src/domain/model/auth/auth_info.dart';
import 'package:nike_store/src/domain/repository/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImp extends AuthRepository {
  static final ValueNotifier<AuthInfo?> authChangeNotifier =
      ValueNotifier(null);
  @override
  Future<AuthInfo> login(String userName, String passWord) async {
    final loginResponse =
        await KiwiContainer().resolve<AuthApi>().login(userName, passWord);
    final AuthInfo authInfo = await AuthInfo(
        accessToken: loginResponse.data['access_token'],
        refreshToken: loginResponse.data['refresh_token']);
    _savingAuthInfo(authInfo);
    return authInfo;
  }

  @override
  Future<AuthInfo> refreshToken(String token) async {
    final refreshTokenResponse =
        await KiwiContainer().resolve<AuthApi>().refreshToken(token);
    final AuthInfo authInfo = await AuthInfo(
        accessToken: refreshTokenResponse.data['access_token'],
        refreshToken: refreshTokenResponse.data['access_token']);
    _savingAuthInfo(authInfo);
    return authInfo;
  }

  @override
  Future<void> signOut() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
    authChangeNotifier.value = null;
  }

  @override
  Future<AuthInfo> signUp(String userName, String passWord) async {
    final signUpResponse =
        await KiwiContainer().resolve<AuthApi>().signUp(userName, passWord);
    final AuthInfo authInfo = await AuthInfo(
        accessToken: signUpResponse.data['access_token'],
        refreshToken: signUpResponse.data['refresh_token']);
    _savingAuthInfo(authInfo);
    return authInfo;
  }

  Future<void> _savingAuthInfo(AuthInfo authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('access_token', authInfo.accessToken);
    sharedPreferences.setString('refresh_token', authInfo.refreshToken);
    loadingAuthInfo();
  }

  Future<void> loadingAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String accessToken =
        sharedPreferences.getString('access_token') ?? '';
    final String refreshToken =
        sharedPreferences.getString('refresh_token') ?? '';
    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifier.value =
          AuthInfo(accessToken: accessToken, refreshToken: refreshToken);
    }
  }
}
