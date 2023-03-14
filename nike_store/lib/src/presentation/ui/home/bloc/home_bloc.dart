import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kiwi/kiwi.dart';
import 'package:meta/meta.dart';
import 'package:nike_store/src/domain/model/banner/banner.dart';
import 'package:nike_store/src/domain/model/product/product.dart';
import 'package:nike_store/src/domain/repository/banner/banner_repository.dart';
import 'package:nike_store/src/domain/repository/product/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      try {
        emit(HomeLoading());
        emit(HomeSuccess(
            latestProducts: await KiwiContainer()
                .resolve<ProductRepository>()
                .getProduct(0),
            popularestProducts: await KiwiContainer()
                .resolve<ProductRepository>()
                .getProduct(1),
            highToLowPrice: await KiwiContainer()
                .resolve<ProductRepository>()
                .getProduct(2),
            lowToHighPrice: await KiwiContainer()
                .resolve<ProductRepository>()
                .getProduct(3),
            banners: await KiwiContainer()
                .resolve<BannerRepository>()
                .getAllBanner()));
      } catch (e) {
        emit(HomeError(errorMessage: 'ارتباط با سرور برقرار نشد'));
      }
    });
  }
}
