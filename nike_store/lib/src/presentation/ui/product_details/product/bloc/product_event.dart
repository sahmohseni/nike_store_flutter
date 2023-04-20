part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object> get props => [];
}

class ProductAddToCart extends ProductEvent {
  final int productId;
  ProductAddToCart({required this.productId});
}
