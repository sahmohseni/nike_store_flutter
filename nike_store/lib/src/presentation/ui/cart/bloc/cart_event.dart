part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent {
  final AuthInfo? authInfo;
  final bool isRefreshing;

  const CartStarted({required this.authInfo, this.isRefreshing = false});
}

class CartAuthChangeInfo extends CartEvent {
  final AuthInfo? authInfo;
  const CartAuthChangeInfo({required this.authInfo});
}

class CartDeleteButtonClicked extends CartEvent {
  final int productId;
  const CartDeleteButtonClicked({required this.productId});
}
