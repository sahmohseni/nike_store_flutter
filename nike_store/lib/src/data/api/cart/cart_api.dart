import 'package:nike_store/src/core/network/base_api.dart';
import 'package:nike_store/src/domain/model/api_response/api_response.dart';

abstract class CartApi extends BaseApi {
  Future<ApiResponse> addToCart(int productId);
  Future<ApiResponse> getAllCartItem();
  Future<ApiResponse> removeFromCart(int cartItemId);
  Future<ApiResponse> changeCount(int cartItemId, int count);
  Future<ApiResponse> count();
}
