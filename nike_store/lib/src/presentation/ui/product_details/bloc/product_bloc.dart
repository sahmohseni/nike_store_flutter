import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kiwi/kiwi.dart';
import 'package:meta/meta.dart';
import 'package:nike_store/src/domain/model/product/product.dart';
import 'package:nike_store/src/domain/repository/cart/cart_repository.dart';
import 'package:nike_store/src/domain/repository/product/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductEntity productEntity;
  ProductBloc({required this.productEntity}) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      try {
        if (event is ProductAddButtonClicked) {
          emit(ProductLoading());
          await KiwiContainer()
              .resolve<CartRepository>()
              .addToCart(event.productId);
          await KiwiContainer().resolve<CartRepository>().count();
          emit(ProductSuccess());
        }
      } catch (e) {
        emit(const ProductError(errorMessage: 'به سبد خرید اضافه نشد'));
      }
    });
  }
}
