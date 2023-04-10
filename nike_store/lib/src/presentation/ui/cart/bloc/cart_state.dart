part of 'cart_bloc.dart';

@immutable
abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartError extends CartState {
  final String errorMessage;
  const CartError({required this.errorMessage});
}

class CartSuccess extends CartState {
  final List<CartResponse> cartItems;
  const CartSuccess({required this.cartItems});
}
