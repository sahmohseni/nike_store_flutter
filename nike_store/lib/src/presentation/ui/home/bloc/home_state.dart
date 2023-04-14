part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ProductEntity> latestProducts;
  final List<ProductEntity> popularestProducts;
  final List<ProductEntity> highToLowPrice;
  final List<ProductEntity> lowToHighPrice;
  final List<BannerEntity> banners;
  const HomeSuccess(
      {required this.latestProducts,
      required this.popularestProducts,
      required this.highToLowPrice,
      required this.lowToHighPrice,
      required this.banners});
}

class HomeError extends HomeState {
  final String errorMessage;
  const HomeError({required this.errorMessage});
}
