part of 'cart_bloc.dart';

abstract class CartState {
  const CartState();
}

class CartLoading extends CartState {}

class CartError extends CartState {
  final String errorMessage;
  const CartError({required this.errorMessage});
}

class CartSuccess extends CartState {
  final CartResponse cartResponse;
  const CartSuccess({required this.cartResponse});
}

class CartAuthRequired extends CartState {}

class CartEmpty extends CartState {}
