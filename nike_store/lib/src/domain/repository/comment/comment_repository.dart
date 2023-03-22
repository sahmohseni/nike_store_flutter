import 'package:nike_store/src/domain/model/comment/comment.dart';

abstract class CommentRepository {
  Future<List<CommentEntity>> getAllComment(int productId);
}
