part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class CommentStart extends CommentEvent {}

class CommentRefresh extends CommentEvent {}
