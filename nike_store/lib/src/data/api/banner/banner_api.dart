import 'package:nike_store/src/core/network/base_api.dart';
import 'package:nike_store/src/domain/model/api_response/api_response.dart';

abstract class BannerApi extends BaseApi {
  Future<ApiResponse> getBanner();
}
