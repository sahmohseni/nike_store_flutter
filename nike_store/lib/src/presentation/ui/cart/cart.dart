import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/domain/model/cart/cart_item.dart';
import 'package:nike_store/src/domain/repository/auth/auth_repository_imp.dart';
import 'package:nike_store/src/domain/repository/cart/cart_repository.dart';
import 'package:nike_store/src/presentation/ui/auth/auth.dart';
import 'package:nike_store/src/presentation/ui/cart/bloc/cart_bloc.dart';
import 'package:nike_store/src/presentation/ui/cart/cart_price_info.dart';
import 'package:nike_store/src/presentation/ui/home/home.dart';
import 'package:nike_store/src/presentation/widgets/app_exception.dart';
import 'package:nike_store/src/presentation/widgets/empty_view.dart';
import 'package:nike_store/src/presentation/widgets/utils.dart';
import 'package:nike_store/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartBloc _cartBloc;
  final RefreshController _refreshController = RefreshController();
  late final StreamSubscription stateSubscription;
  @override
  void initState() {
    AuthRepositoryImp.authChangeNotifier.addListener(authChangeNotifierMode);
    super.initState();
  }

  void authChangeNotifierMode() {
    _cartBloc.add(CartAuthChangeInfo(
        authInfo: AuthRepositoryImp.authChangeNotifier.value));
  }

  @override
  void dispose() {
    AuthRepositoryImp.authChangeNotifier.removeListener(authChangeNotifierMode);
    stateSubscription.cancel();
    super.dispose();
  }

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
          final stateSubscription = cartBloc.stream.listen((state) {
            if (_refreshController.isRefresh) {
              if (state is CartSuccess) {
                _refreshController.refreshCompleted();
              }
            }
          });
          _cartBloc = cartBloc;
          cartBloc.add(CartStarted(
              authInfo: AuthRepositoryImp.authChangeNotifier.value));
          return cartBloc;
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartSuccess) {
              return SmartRefresher(
                controller: _refreshController,
                onRefresh: () {
                  BlocProvider.of<CartBloc>(context).add(CartStarted(
                      authInfo: AuthRepositoryImp.authChangeNotifier.value,
                      isRefreshing: true));
                },
                header: const ClassicHeader(
                  completeText: 'به روزرسانی سبدخرید با موفقیت انجام شد',
                  idleText: 'برای به روزرسانی پایین بکشید',
                  refreshingText: 'در حال به روزرسانی',
                  releaseText: 'رها کنید',
                ),
                child: ListView.builder(
                  itemCount: state.cartResponse.cartItems.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.cartResponse.cartItems.length) {
                      final data = state.cartResponse.cartItems[index];
                      return CartItem(
                        onIncrementItemTap: () {
                          BlocProvider.of<CartBloc>(context).add(
                              IncrementItemCount(cartItemId: data.cartItemId));
                        },
                        onDecremnetItemTap: () {
                          if (data.count > 1) {
                            BlocProvider.of<CartBloc>(context).add(
                                DecrementItemCount(
                                    cartItemId: data.cartItemId));
                          }
                        },
                        data: data,
                        onTap: () {
                          BlocProvider.of<CartBloc>(context).add(
                              CartDeleteButtonClicked(
                                  productId: data.cartItemId));
                        },
                      );
                    } else {
                      return CartPriceInfo(
                          payablePrice: state.cartResponse.payablePrice,
                          totalPrice: state.cartResponse.totalPrice,
                          shippingCost: state.cartResponse.shippingCost);
                    }
                  },
                ),
              );
            } else if (state is CartLoading) {
              return const Center(
                child: CupertinoActivityIndicator(
                  color: LightTheme.primaryColor,
                ),
              );
            } else if (state is CartError) {
              return const Center(
                child: Text('در نمایش سبد خرید مشکلی پیش آمده است '),
              );
            } else if (state is CartAuthRequired) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EmptyView(
                        message: const Text(
                          'برای مشاهده سبدخرید باید وارد شوید',
                          style: TextStyle(fontFamily: 'dana'),
                        ),
                        image: SvgPicture.asset(
                          'assets/images/auth_required.svg',
                          width: 120,
                        )),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                                LightTheme.primaryColor)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AuthScreen(),
                          ));
                        },
                        icon: const Icon(CupertinoIcons.arrow_left),
                        label: const Text(
                          'ورود',
                          style: TextStyle(
                              fontFamily: 'dana',
                              fontSize: 14,
                              color: Colors.white),
                        ))
                  ],
                ),
              );
            } else if (state is CartEmpty) {
              return EmptyView(
                  message: const Text('سبد خرید شما خالی است'),
                  image: SvgPicture.asset(
                    'assets/images/empty_cart.svg',
                    width: 120,
                  ));
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

class CartItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final GestureTapCallback onIncrementItemTap;
  final GestureTapCallback onDecremnetItemTap;

  const CartItem({
    super.key,
    required this.data,
    required this.onTap,
    required this.onIncrementItemTap,
    required this.onDecremnetItemTap,
  });

  final CartItemEntity data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: LightTheme.itemBackGroundColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 2)
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
                    child: ImageLoadingService(imageUrl: data.product.image)),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    data.product.title,
                    style: const TextStyle(
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
                    const Text('تعداد'),
                    Row(
                      children: [
                        IconButton(
                            onPressed: onIncrementItemTap,
                            icon: const Icon(CupertinoIcons.plus_square)),
                        const SizedBox(
                          width: 4,
                        ),
                        data.isChangeCount
                            ? const CupertinoActivityIndicator(
                                color: LightTheme.primaryColor,
                              )
                            : Text(
                                data.count.toString(),
                                style: const TextStyle(
                                    fontFamily: 'dana',
                                    fontWeight: FontWeight.bold),
                              ),
                        const SizedBox(
                          width: 4,
                        ),
                        IconButton(
                          icon: const Icon(CupertinoIcons.minus_square),
                          onPressed: onDecremnetItemTap,
                        )
                      ],
                    )
                  ],
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data.product.previous_price.withPriceLabel,
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontFamily: 'dana',
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Text(
                      data.product.price.withPriceLabel,
                      style: const TextStyle(
                        fontFamily: 'dana',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 2,
          ),
          Center(
              child: TextButton(
                  onPressed: onTap,
                  child: Center(
                    child: TextButton(
                        onPressed: onTap,
                        child: data.deleteButtonLoading
                            ? const CupertinoActivityIndicator()
                            : const Text(
                                'حذف از سبد',
                                style: TextStyle(
                                    fontFamily: 'dana',
                                    color: LightTheme.primaryColor),
                              )),
                  )))
        ],
      ),
    );
  }
}
