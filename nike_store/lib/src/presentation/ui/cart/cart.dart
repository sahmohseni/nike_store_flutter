import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/domain/model/auth/auth_info.dart';
import 'package:nike_store/src/domain/repository/auth/auth_repository.dart';
import 'package:nike_store/src/domain/repository/auth/auth_repository_imp.dart';
import 'package:nike_store/src/presentation/ui/auth/auth.dart';
import 'package:nike_store/src/presentation/ui/cart/bloc/cart_bloc.dart';
import 'package:nike_store/src/presentation/ui/home/home.dart';
import 'package:nike_store/src/presentation/widgets/app_exception.dart';
import 'package:nike_store/src/presentation/widgets/utils.dart';
import 'package:nike_store/theme.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartBloc cartBlocInstance;
  @override
  void initState() {
    AuthRepositoryImp.authChangeNotifier.addListener(authChangeNotifierMode);
    super.initState();
  }

  void authChangeNotifierMode() {
    cartBlocInstance.add(CartAuthChangeMode(
        authInfo: AuthRepositoryImp.authChangeNotifier.value!));
  }

  @override
  void dispose() {
    AuthRepositoryImp.authChangeNotifier.removeListener(authChangeNotifierMode);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          cartBlocInstance = cartBloc;
          cartBloc.add(
              CartStart(authInfo: AuthRepositoryImp.authChangeNotifier.value));
          return cartBloc;
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CupertinoActivityIndicator(
                  color: LightTheme.primaryColor,
                ),
              );
            } else if (state is CartError) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style:
                      const TextStyle(fontFamily: 'dana', color: Colors.white),
                ),
              );
            } else if (state is CartSuccess) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.cartResponse.cartItem.length,
                itemBuilder: (context, index) {
                  final data = state.cartResponse.cartItem[index];
                  return Container(
                    margin: const EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 1,
                              color: LightTheme.itemBackGroundColor
                                  .withOpacity(0.4))
                        ]),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: ImageLoadingService(
                                    imageUrl: data.productEntity.image),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              Expanded(
                                child: Text(
                                  data.productEntity.title,
                                  style: const TextStyle(
                                      fontFamily: 'dana',
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 35),
                              child: Text('تعداد'),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.minus_circle,
                                      size: 20,
                                    )),
                                Text(
                                  data.count.toString(),
                                  style: const TextStyle(
                                      fontFamily: 'dana',
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.plus_circle,
                                      size: 20,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 160),
                                  child: Column(
                                    children: [
                                      Text(
                                        data.productEntity.previous_price
                                            .withPriceLabel,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontFamily: 'dana',
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      ),
                                      Text(
                                        data.productEntity.price.withPriceLabel,
                                        style: const TextStyle(
                                            fontFamily: 'dana', fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            } else if (state is CartAuthRequired) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'برای مشاهده ی سبد خرید وارد حساب خود شوید',
                      style: TextStyle(fontFamily: 'dana'),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                LightTheme.primaryColor)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AuthScreen(),
                          ));
                        },
                        child: const Text(
                          'ورود',
                          style: TextStyle(
                              fontFamily: 'dana', color: Colors.white),
                        ))
                  ],
                ),
              );
            } else {
              throw AppException(errorMessage: 'خطا');
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
      //                       backgroundColor: MaterialStateProperty.all(
      //                           LightTheme.primaryColor)),
      //                   onPressed: () {
      //                     KiwiContainer().resolve<AuthRepository>().signOut();
      //                   },
      //                   child: Text(
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
      //                   child: Text(
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
