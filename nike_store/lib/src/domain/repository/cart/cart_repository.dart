import 'package:nike_store/src/domain/model/cart/add_to_cart_response.dart';
import 'package:nike_store/src/domain/model/cart/cart_response.dart';

abstract class CartRepository {
  Future<AddToCartResponseEntity> addToCart(int productId);
  Future<CartResponse> getAllCartItem();
  Future<void> changeCount(int cartItemId, int count);
  Future<void> removeFromCart(int cartItemId);
  Future<int> count();
}
