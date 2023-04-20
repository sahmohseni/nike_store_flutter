import 'package:nike_store/src/domain/model/cart/cart_item.dart';

class CartResponseEntity {
  final List<CartItemEntity> cartItem;
  final int payablePrice;
  final int totalPrice;
  final int shippingCost;
  CartResponseEntity.fromJson(Map<String, dynamic> json)
      : cartItem = CartItemEntity.parseJsonArray(json['cart_items']),
        payablePrice = json['payable_price'],
        totalPrice = json['total_price'],
        shippingCost = json['shipping_cost'];
}
