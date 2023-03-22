import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/data/api/comment/comment_api.dart';
import 'package:nike_store/src/domain/model/comment/comment.dart';
import 'package:nike_store/src/domain/repository/comment/comment_repository.dart';

class CommentRepositoryImp extends CommentRepository {
  @override
  Future<List<CommentEntity>> getAllComment(int productId) async {
    final getRespone = await KiwiContainer()
        .resolve<CommentApi>()
        .getCommentResponse(productId);
    final List<CommentEntity> commentList = [];
    (getRespone.data as List<dynamic>).forEach((element) {
      commentList.add(CommentEntity.fromJson(element));
    });
    return commentList;
  }
}
