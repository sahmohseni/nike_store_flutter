import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kiwi/kiwi.dart';
import 'package:meta/meta.dart';
import 'package:nike_store/src/domain/repository/auth/auth_repository.dart';
import 'package:nike_store/src/domain/repository/cart/cart_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool loginMode;
  AuthBloc({this.loginMode = true}) : super(AuthInitial(loginMode: loginMode)) {
    on<AuthEvent>((event, emit) async {
      try {
        if (event is AuthButtonClicked) {
          emit(AuthLoading(loginMode: loginMode));
          if (loginMode) {
            await KiwiContainer()
                .resolve<AuthRepository>()
                .login(event.userName, event.passWord);
            await KiwiContainer().resolve<CartRepository>().count();
            emit(AuthSuccess(loginMode: loginMode));
          } else {
            await KiwiContainer()
                .resolve<AuthRepository>()
                .signUp(event.userName, event.passWord);
            emit(AuthSuccess(loginMode: loginMode));
          }
        } else if (event is AuthChangeModeClicked) {
          loginMode = !loginMode;
          emit(AuthInitial(loginMode: loginMode));
        }
      } catch (e) {
        emit(AuthError('اطلاعات به درستی وارد نشده است', loginMode: loginMode));
      }
    });
  }
}
