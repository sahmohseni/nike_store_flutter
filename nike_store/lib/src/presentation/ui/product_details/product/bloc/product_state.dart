part of 'product_bloc.dart';

@immutable
abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductAddLoading extends ProductState {}

class ProductAddError extends ProductState {
  final String errorMessage;
  ProductAddError({required this.errorMessage});
}

class ProductAddSuccess extends ProductState {}
