import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/data/api/auth/auth_api.dart';
import 'package:nike_store/src/data/api/auth/auth_api_imp.dart';
import 'package:nike_store/src/data/api/banner/banner_api.dart';
import 'package:nike_store/src/data/api/banner/banner_api_imp.dart';
import 'package:nike_store/src/data/api/comment/comment_api.dart';
import 'package:nike_store/src/data/api/comment/comment_api_provider.dart';
import 'package:nike_store/src/data/api/product/product_api.dart';
import 'package:nike_store/src/data/api/product/product_api_imp.dart';

void apiInjector() {
  KiwiContainer().registerFactory<ProductApi>((container) => ProductApiImp());
  KiwiContainer().registerFactory<BannerApi>((container) => BannerApiImp());
  KiwiContainer().registerFactory<CommentApi>((container) => CommentApiImp());
  KiwiContainer().registerFactory<AuthApi>((container) => AuthApiImp());
}
