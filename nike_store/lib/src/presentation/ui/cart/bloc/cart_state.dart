part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final CartResponseEntity cartResponse;
  CartSuccess({required this.cartResponse});
}

class CartError extends CartState {
  final String errorMessage;
  CartError({required this.errorMessage});
}

class CartAuthRequired extends CartState {}
