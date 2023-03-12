import 'package:nike_store/src/domain/model/product/product.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProduct(int sortId);
  Future<List<ProductEntity>> searchProduct(String searchTerm);
}
