import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/data/api/cart/cart_api.dart';
import 'package:nike_store/src/domain/model/cart/add_to_cart_response.dart';
import 'package:nike_store/src/domain/model/cart/cart_response.dart';
import 'package:nike_store/src/domain/repository/cart/cart_repository.dart';

class CartRepositoryImp extends CartRepository {
  @override
  Future<AddToCartResponseEntity> addToCart(int productId) async {
    final response =
        await KiwiContainer().resolve<CartApi>().addToCart(productId);
    return AddToCartResponseEntity.fromJson(response.data);
  }

  @override
  Future<CartResponse> getAllCartItem() async {
    final response = await KiwiContainer().resolve<CartApi>().getAllCartItem();
    return CartResponse.fromJson(response.data);
  }

  @override
  Future<void> removeFromCart(int cartItemId) async {
    final response =
        await KiwiContainer().resolve<CartApi>().removeFromCart(cartItemId);
  }
}
