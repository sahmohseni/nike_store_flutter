import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kiwi/kiwi.dart';
import 'package:meta/meta.dart';
import 'package:nike_store/src/domain/repository/cart/cart_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is ProductAddToCart) {
        try {
          emit(ProductAddLoading());
          await KiwiContainer()
              .resolve<CartRepository>()
              .addToCart(event.productId);
          emit(ProductAddSuccess());
        } catch (e) {
          emit(ProductAddError(errorMessage: 'دوباره امتحان کنید'));
        }
      }
    });
  }
}
