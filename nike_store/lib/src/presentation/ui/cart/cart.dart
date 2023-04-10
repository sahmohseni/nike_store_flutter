import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/domain/model/auth/auth_info.dart';
import 'package:nike_store/src/domain/repository/auth/auth_repository.dart';
import 'package:nike_store/src/domain/repository/auth/auth_repository_imp.dart';
import 'package:nike_store/src/domain/repository/cart/cart_repository.dart';
import 'package:nike_store/src/presentation/ui/auth/auth.dart';
import 'package:nike_store/src/presentation/ui/cart/bloc/cart_bloc.dart';
import 'package:nike_store/src/presentation/ui/home/home.dart';
import 'package:nike_store/src/presentation/widgets/app_exception.dart';
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
      body: BlocProvider<CartBloc>(
        create: (context) {
          final cartBloc = CartBloc();
          cartBloc.add(CartStarted());
          return cartBloc;
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartSuccess) {
              return ListView.builder(
                itemCount: state.cartResponse.cartItems.length,
                itemBuilder: (context, index) {
                  final data = state.cartResponse.cartItems[index];
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: LightTheme.itemBackGroundColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.01),
                              blurRadius: 2)
                        ]),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: ImageLoadingService(
                                      imageUrl: data.product.image)),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Text(
                                  data.product.title,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'dana',
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text('تعداد'),
                                  Row(
                                    children: [
                                      const Icon(CupertinoIcons.plus_square),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        data.count.toString(),
                                        style: TextStyle(
                                            fontFamily: 'dana',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      const Icon(CupertinoIcons.minus_square)
                                    ],
                                  )
                                ],
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    data.product.previous_price.toString() +
                                        " " +
                                        "تومان",
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontFamily: 'dana',
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  Text(
                                    data.product.price.toString() +
                                        " " +
                                        "تومان",
                                    style: TextStyle(
                                      fontFamily: 'dana',
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else if (state is CartLoading) {
              return const Center(
                child: CupertinoActivityIndicator(
                  color: LightTheme.primaryColor,
                ),
              );
            } else if (state is CartError) {
              return Center(
                child: Text('در نمایش سبد خرید مشکلی پیش آمده است '),
              );
            } else {
              throw AppException(errorMessage: 'error');
            }
          },
        ),
      ),

      // body: ValueListenableBuilder<AuthInfo?>(
      //   valueListenable: AuthRepositoryImp.authChangeNotifier,
      //   builder: (context, authState, child) {
      //     bool isAuthenticated =
      //         authState != null && authState.accessToken.isNotEmpty;
      //     return Center(
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Text(isAuthenticated ? 'خوش آمدید' : 'ورود'),
      //           const SizedBox(
      //             height: 8,
      //           ),
      //           isAuthenticated
      //               ? ElevatedButton(
      //                   style: ButtonStyle(
      //                       elevation: MaterialStateProperty.all(0),
      //                       backgroundColor: MaterialStateProperty.all(
      //                           LightTheme.primaryColor)),
      //                   onPressed: () {
      //                     KiwiContainer().resolve<AuthRepository>().signOut();
      //                   },
      //                   child: const Text(
      //                     'خروج از حساب',
      //                     style: TextStyle(
      //                         fontFamily: 'dana', color: Colors.white),
      //                   ))
      //               : ElevatedButton(
      //                   style: ButtonStyle(
      //                       backgroundColor: MaterialStateProperty.all(
      //                           LightTheme.primaryColor)),
      //                   onPressed: () {
      //                     Navigator.of(context, rootNavigator: true).push(
      //                         MaterialPageRoute(
      //                             builder: (context) => AuthScreen()));
      //                   },
      //                   child: const Text(
      //                     'ورود به حساب',
      //                     style: TextStyle(
      //                         fontFamily: 'dana', color: Colors.white),
      //                   ))
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
