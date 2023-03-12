import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/core/network/api_provider/api_provider.dart';
import 'package:nike_store/src/data/api/banner/banner_api.dart';
import 'package:nike_store/src/domain/model/api_response/api_response.dart';

class BannerApiImp extends BannerApi {
  @override
  Future<ApiResponse> getBanner() async {
    final response = await KiwiContainer()
        .resolve<ApiProvider>()
        .get('http://expertdevelopers.ir/api/v1/banner/slider');
    return ApiResponse.fromResponse(response: response);
  }
}
