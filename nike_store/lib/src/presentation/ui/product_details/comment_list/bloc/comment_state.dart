part of 'comment_bloc.dart';

@immutable
abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentLoading extends CommentState {}

class CommentSuccess extends CommentState {
  final List<CommentEntity> comments;
  CommentSuccess({required this.comments});
}

class CommentError extends CommentState {
  final String errorMessage;
  CommentError({required this.errorMessage});
}
