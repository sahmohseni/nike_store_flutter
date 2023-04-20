import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/data/api/cart/cart_api.dart';
import 'package:nike_store/src/domain/model/cart/add_to_cart.dart';
import 'package:nike_store/src/domain/model/cart/cart_response.dart';

import 'package:nike_store/src/domain/repository/cart/cart_repository.dart';

class CartRepositoryImp extends CartRepository {
  @override
  Future<AddToCartEntity> addToCart(int productId) async {
    final response =
        await KiwiContainer().resolve<CartApi>().addToCart(productId);
    return AddToCartEntity.fromJson(response.data);
  }

  @override
  Future<CartResponseEntity> getAllCartItem() async {
    final getAllCartItemResponse =
        await KiwiContainer().resolve<CartApi>().getAllCartItem();
    return CartResponseEntity.fromJson(getAllCartItemResponse.data);
  }

  @override
  Future<void> deleteFromCart(int cartItemId) async {
    final response =
        await KiwiContainer().resolve<CartApi>().deleteFromCart(cartItemId);
  }
}
