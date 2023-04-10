import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/domain/model/auth/auth_info.dart';
import 'package:nike_store/src/domain/repository/auth/auth_repository.dart';
import 'package:nike_store/src/domain/repository/auth/auth_repository_imp.dart';
import 'package:nike_store/src/domain/repository/cart/cart_repository.dart';
import 'package:nike_store/src/presentation/ui/auth/auth.dart';
import 'package:nike_store/theme.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    KiwiContainer().resolve<CartRepository>().getAllCartItem().then(
      (value) {
        debugPrint(value.toString());
      },
    ).catchError((e) {
      debugPrint(e.toString());
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: LightTheme.primaryColor,
        centerTitle: true,
        title: const Text(
          'سبد خرید',
          style: TextStyle(fontFamily: 'dana', color: Colors.white),
        ),
      ),
      body: ValueListenableBuilder<AuthInfo?>(
        valueListenable: AuthRepositoryImp.authChangeNotifier,
        builder: (context, authState, child) {
          bool isAuthenticated =
              authState != null && authState.accessToken.isNotEmpty;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(isAuthenticated ? 'خوش آمدید' : 'ورود'),
                const SizedBox(
                  height: 8,
                ),
                isAuthenticated
                    ? ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                                LightTheme.primaryColor)),
                        onPressed: () {
                          KiwiContainer().resolve<AuthRepository>().signOut();
                        },
                        child: const Text(
                          'خروج از حساب',
                          style: TextStyle(
                              fontFamily: 'dana', color: Colors.white),
                        ))
                    : ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                LightTheme.primaryColor)),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => AuthScreen()));
                        },
                        child: const Text(
                          'ورود به حساب',
                          style: TextStyle(
                              fontFamily: 'dana', color: Colors.white),
                        ))
              ],
            ),
          );
        },
      ),
    );
  }
}
