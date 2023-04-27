import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:meta/meta.dart';
import 'package:nike_store/src/data/api/cart/cart_api.dart';
import 'package:nike_store/src/domain/model/auth/auth_info.dart';
import 'package:nike_store/src/domain/model/cart/cart_response.dart';
import 'package:nike_store/src/domain/repository/auth/auth_repository_imp.dart';
import 'package:nike_store/src/domain/repository/cart/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartEvent>((event, emit) async {
      if (event is CartStarted) {
        final authInfo = AuthRepositoryImp.authChangeNotifier.value;
        if (authInfo == null || authInfo.accessToken.isEmpty) {
          emit(CartAuthRequired());
        } else {
          try {
            if (!event.isRefreshing) {
              emit(CartLoading());
            }

            final result = await KiwiContainer()
                .resolve<CartRepository>()
                .getAllCartItem();
            emit(CartSuccess(cartResponse: result));
          } catch (e) {
            emit(const CartError(
                errorMessage: 'نمایش سبد خرید با مشکل مواجه شده است'));
          }
        }
      } else if (event is CartAuthChangeInfo) {
        final authInfo = AuthRepositoryImp.authChangeNotifier.value;
        if (authInfo == null || authInfo.accessToken.isEmpty) {
          emit(CartAuthRequired());
        } else {
          if (state is CartAuthRequired) {
            try {
              emit(CartLoading());
              final result = await KiwiContainer()
                  .resolve<CartRepository>()
                  .getAllCartItem();
              emit(CartSuccess(cartResponse: result));
            } catch (e) {
              emit(const CartError(
                  errorMessage: 'نمایش سبد خرید با مشکل مواجه شده است'));
            }
          }
        }
      } else if (event is CartDeleteButtonClicked) {
        if (state is CartSuccess) {
          final successState = (state as CartSuccess);
          final index = successState.cartResponse.cartItems
              .indexWhere((element) => element.cartItemId == event.productId);
          successState.cartResponse.cartItems[index].deleteButtonLoading = true;
          emit(CartSuccess(cartResponse: successState.cartResponse));
        }
        await KiwiContainer()
            .resolve<CartRepository>()
            .removeFromCart(event.productId);
        await KiwiContainer().resolve<CartRepository>().count();
        if (state is CartSuccess) {
          final successState = (state as CartSuccess);
          successState.cartResponse.cartItems
              .removeWhere((element) => element.cartItemId == event.productId);
          if (successState.cartResponse.cartItems.isEmpty) {
            emit(CartEmpty());
          } else {
            emit(calculateCartPrice(successState.cartResponse));
          }
        }
      } else if (event is IncrementItemCount || event is DecrementItemCount) {
        int cartItemId = 0;
        try {
          if (event is IncrementItemCount) {
            cartItemId = event.cartItemId;
          } else if (event is DecrementItemCount) {
            cartItemId = event.cartItemId;
          }
          final successState = (state as CartSuccess);
          final index = successState.cartResponse.cartItems
              .indexWhere((element) => element.cartItemId == cartItemId);
          successState.cartResponse.cartItems[index].isChangeCount = true;
          emit(CartSuccess(cartResponse: successState.cartResponse));
          final newCount = event is IncrementItemCount
              ? ++successState.cartResponse.cartItems[index].count
              : --successState.cartResponse.cartItems[index].count;
          await KiwiContainer()
              .resolve<CartRepository>()
              .changeCount(cartItemId, newCount);
          await KiwiContainer().resolve<CartRepository>().count();
          successState.cartResponse.cartItems
              .firstWhere((element) => element.cartItemId == cartItemId)
            ..count = newCount
            ..isChangeCount = false;
          emit(calculateCartPrice(successState.cartResponse));
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    });
  }

  CartSuccess calculateCartPrice(CartResponse cartResponse) {
    int payablePrice = 0;
    int totalPrice = 0;
    int shippingCost = 0;
    cartResponse.cartItems.forEach((element) {
      payablePrice += element.product.previous_price * element.count;
      totalPrice += element.product.price * element.count;
    });
    shippingCost = payablePrice >= 500000 ? 0 : 30000;
    cartResponse.totalPrice = totalPrice;
    cartResponse.payablePrice = payablePrice;
    cartResponse.shippingCost = shippingCost;
    return CartSuccess(cartResponse: cartResponse);
  }
}
