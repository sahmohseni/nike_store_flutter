part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStart extends CartEvent {
  final AuthInfo? authInfo;
  const CartStart({required this.authInfo});
}

class CartAuthChangeMode extends CartEvent {
  final AuthInfo authInfo;
  const CartAuthChangeMode({required this.authInfo});
}

class CartDeleteButtonClicked extends CartEvent {
  final int cartItemId;
  const CartDeleteButtonClicked({required this.cartItemId});
}
