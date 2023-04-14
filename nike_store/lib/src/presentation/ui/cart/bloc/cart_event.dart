part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent {
  final AuthInfo? authInfo;
  const CartStarted({required this.authInfo});
}

class CartAuthChangeInfo extends CartEvent {
  final AuthInfo? authInfo;
  const CartAuthChangeInfo({required this.authInfo});
}

class CartDeleteButtonClicked extends CartEvent {
  final int productId;
  const CartDeleteButtonClicked({required this.productId});
}
