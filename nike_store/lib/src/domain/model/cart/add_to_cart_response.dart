class AddToCartResponseEntity {
  final int productId;
  final int count;
  final int cartItemId;
  AddToCartResponseEntity.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        count = json['count'],
        cartItemId = json['id'];
}
