import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/domain/repository/auth/auth_repository.dart';
import 'package:nike_store/src/domain/repository/auth/auth_repository_imp.dart';
import 'package:nike_store/src/domain/repository/banner/banner_repository.dart';
import 'package:nike_store/src/domain/repository/banner/banner_repository_imp.dart';
import 'package:nike_store/src/domain/repository/comment/comment_repository.dart';
import 'package:nike_store/src/domain/repository/comment/comment_repository_imp.dart';
import 'package:nike_store/src/domain/repository/product/product_repository.dart';
import 'package:nike_store/src/domain/repository/product/product_repository_imp.dart';

void repoInjector() {
  KiwiContainer().registerSingleton<ProductRepository>(
      (container) => ProductRepositoryImp());
  KiwiContainer().registerSingleton<BannerRepository>(
      (container) => BannerRepositoryImp());
  KiwiContainer().registerSingleton<CommentRepository>(
      (container) => CommentRepositoryImp());
  KiwiContainer()
      .registerSingleton<AuthRepository>((container) => AuthRepositoryImp());
  KiwiContainer()
      .registerSingleton<AuthRepositoryImp>((container) => AuthRepositoryImp());
}
