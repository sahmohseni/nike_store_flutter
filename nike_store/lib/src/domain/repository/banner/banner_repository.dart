import 'package:nike_store/src/domain/model/banner/banner.dart';

abstract class BannerRepository {
  Future<List<BannerEntity>> getAllBanner();
}
