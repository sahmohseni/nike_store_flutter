import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/core/network/api_provider/api_provider.dart';
import 'package:nike_store/src/data/api/comment/comment_api.dart';
import 'package:nike_store/src/domain/model/api_response/api_response.dart';

class CommentApiImp extends CommentApi {
  @override
  Future<ApiResponse> getCommentResponse(int productId) async {
    final response = await KiwiContainer().resolve<ApiProvider>().get(
        'http://expertdevelopers.ir/api/v1/comment/list?product_id=$productId');
    return ApiResponse.fromResponse(response: response);
  }
}
