import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/data/api/product/product_api.dart';
import 'package:nike_store/src/domain/model/product/product.dart';
import 'package:nike_store/src/domain/repository/product/product_repository.dart';

class ProductRepositoryImp extends ProductRepository {
  @override
  Future<List<ProductEntity>> getProduct(int sortId) async {
    final getResponse =
        await KiwiContainer().resolve<ProductApi>().getProduct(sortId);
    final List<ProductEntity> products = [];
    (getResponse.data as List<dynamic>).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });
    return products;
  }

  @override
  Future<List<ProductEntity>> searchProduct(String searchTerm) async {
    final getResponse =
        await KiwiContainer().resolve<ProductApi>().searchProduct(searchTerm);
    final List<ProductEntity> searchList = [];
    (getResponse.data as List<dynamic>).forEach((element) {
      searchList.add(ProductEntity.fromJson(element));
    });
    return searchList;
  }
}
