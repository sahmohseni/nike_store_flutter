// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kiwi/kiwi.dart';
import 'package:meta/meta.dart';
import 'package:nike_store/src/domain/model/comment/comment.dart';
import 'package:nike_store/src/domain/repository/comment/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final int productId;
  CommentBloc(
    this.productId,
  ) : super(CommentLoading()) {
    on<CommentEvent>((event, emit) async {
      try {
        emit(CommentLoading());
        emit(CommentSuccess(
            comments: await KiwiContainer()
                .resolve<CommentRepository>()
                .getAllComment(productId)));
      } catch (e) {
        emit(CommentError(errorMessage: 'ارور'));
      }
    });
  }
}
