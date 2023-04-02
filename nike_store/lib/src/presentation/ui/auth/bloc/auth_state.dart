part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  bool loginMode;
  AuthState({required this.loginMode});

  @override
  List<Object> get props => [loginMode];
}

class AuthInitial extends AuthState {
  AuthInitial({required super.loginMode});
}

class AuthSuccess extends AuthState {
  AuthSuccess({required super.loginMode});
}

class AuthLoading extends AuthState {
  AuthLoading({required super.loginMode});
}

class AuthError extends AuthState {
  final String errorMessage;
  AuthError(this.errorMessage, {required super.loginMode});
}
