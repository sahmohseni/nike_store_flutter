import 'package:nike_store/src/domain/model/product/product.dart';

class CartItemEntity {
  final int cartItemId;
  final ProductEntity product;
  int count;
  bool deleteButtonLoading = false;
  bool isChangeCount = false;
  CartItemEntity.fromJson(Map<String, dynamic> json)
      : cartItemId = json['cart_item_id'],
        product = ProductEntity.fromJson(json['product']),
        count = json['count'];

  static List<CartItemEntity> parseJsonArray(List<dynamic> jsonArray) {
    final List<CartItemEntity> cartItems = [];
    jsonArray.forEach((element) {
      cartItems.add(CartItemEntity.fromJson(element));
    });
    return cartItems;
  }
}
