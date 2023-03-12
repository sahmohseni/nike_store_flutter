import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/core/network/api_provider/api_provider.dart';
import 'package:nike_store/src/data/api/product/product_api.dart';
import 'package:nike_store/src/domain/model/api_response/api_response.dart';

class ProductApiImp extends ProductApi {
  @override
  Future<ApiResponse> getProduct(int sortId) async {
    final response = await KiwiContainer()
        .resolve<ApiProvider>()
        .get('http://expertdevelopers.ir/api/v1/product/list?sort=$sortId');
    return ApiResponse.fromResponse(response: response);
  }

  @override
  Future<ApiResponse> searchProduct(String searchTerm) async {
    final response = await KiwiContainer()
        .resolve<ApiProvider>()
        .get('http://expertdevelopers.ir/api/v1/product/search?q=$searchTerm');
    return ApiResponse.fromResponse(response: response);
  }
}
