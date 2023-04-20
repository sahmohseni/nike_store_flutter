import 'package:nike_store/src/domain/model/product/product.dart';

class CartItemEntity {
  final int cartItemId;
  final ProductEntity productEntity;
  final int count;
  CartItemEntity.fromJson(Map<String, dynamic> json)
      : cartItemId = json['cart_item_id'],
        productEntity = ProductEntity.fromJson(json['product']),
        count = json['count'];
  static List<CartItemEntity> parseJsonArray(List<dynamic> jsonArray) {
    final List<CartItemEntity> cartItems = [];
    jsonArray.forEach((element) {
      cartItems.add(CartItemEntity.fromJson(element));
    });
    return cartItems;
  }
}
