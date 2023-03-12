import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/data/api/banner/banner_api.dart';
import 'package:nike_store/src/domain/model/banner/banner.dart';
import 'package:nike_store/src/domain/repository/banner/banner_repository.dart';

class BannerRepositoryImp extends BannerRepository {
  @override
  Future<List<BannerEntity>> getAllBanner() async {
    final response = await KiwiContainer().resolve<BannerApi>().getBanner();
    final List<BannerEntity> banners = [];
    (response.data as List<dynamic>).forEach((element) {
      banners.add(BannerEntity.fromJson(element));
    });
    return banners;
  }
}
