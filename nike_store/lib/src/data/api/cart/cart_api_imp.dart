import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/core/network/api_provider/api_provider.dart';
import 'package:nike_store/src/data/api/cart/cart_api.dart';
import 'package:nike_store/src/domain/model/api_response/api_response.dart';

class CartApiImp extends CartApi {
  @override
  Future<ApiResponse> addToCart(int productId) async {
    final addToCartResponse = await KiwiContainer().resolve<ApiProvider>().post(
        'http://expertdevelopers.ir/api/v1/cart/add',
        bodyParameter: {'product_id': productId});
    return ApiResponse.fromResponse(response: addToCartResponse);
  }

  @override
  Future<ApiResponse> changeCount(int cartItemId, int count) async {
    final changeCountResponse = await KiwiContainer()
        .resolve<ApiProvider>()
        .post('http://expertdevelopers.ir/api/v1/cart/changeCount',
            bodyParameter: {'cart_item_id': cartItemId, 'count': count});
    return ApiResponse.fromResponse(response: changeCountResponse);
  }

  @override
  Future<ApiResponse> count() async {
    final countResponse = await KiwiContainer()
        .resolve<ApiProvider>()
        .get('http://expertdevelopers.ir/api/v1/cart/count');
    return ApiResponse.fromResponse(response: countResponse);
  }

  @override
  Future<ApiResponse> getAllCartItem() async {
    final getAllCartItemResponse = await KiwiContainer()
        .resolve<ApiProvider>()
        .get('http://expertdevelopers.ir/api/v1/cart/list');
    return ApiResponse.fromResponse(response: getAllCartItemResponse);
  }

  @override
  Future<ApiResponse> removeFromCart(int cartItemId) async {
    final removeFromCartResponse = await KiwiContainer()
        .resolve<ApiProvider>()
        .post('http://expertdevelopers.ir/api/v1/cart/remove',
            bodyParameter: {'cart_item_id': cartItemId});
    return ApiResponse.fromResponse(response: removeFromCartResponse);
  }
}
