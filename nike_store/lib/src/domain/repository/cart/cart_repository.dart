import 'package:nike_store/src/domain/model/cart/add_to_cart.dart';
import 'package:nike_store/src/domain/model/cart/cart_response.dart';

abstract class CartRepository {
  Future<AddToCartEntity> addToCart(int productId);
  Future<CartResponseEntity> getAllCartItem();
  Future<void> deleteFromCart(int cartItemId);
}
