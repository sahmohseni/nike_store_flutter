part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductAddButtonClicked extends ProductEvent {
  final int productId;
  ProductAddButtonClicked({required this.productId});
}
