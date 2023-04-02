part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStart extends AuthEvent {}

class AuthButtonClicked extends AuthEvent {
  final String userName;
  final String passWord;
  const AuthButtonClicked({required this.userName, required this.passWord});
}

class AuthChangeModeClicked extends AuthEvent {}
