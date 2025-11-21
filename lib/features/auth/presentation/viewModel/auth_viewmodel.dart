import 'package:esacc_flutter_task/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'auth_intent.dart';
import 'auth_state.dart';

@injectable
class AuthViewModel extends Cubit<AuthState> {
final LoginUseCase _loginUseCase;
  AuthViewModel(this._loginUseCase) : super( AuthInitialState());

  void handleIntent(AuthIntent intent) {
    switch (intent) {
      case LoginWithGoogleIntent():
        _loginWithGoogle();
      case LoginWithFacebookIntent():
        _loginWithFacebook();
    }
  }

  Future<void> _loginWithGoogle() async {
    emit(AuthLoadingState());
    final result = await _loginUseCase.invoke();

    result.when(
      success: (user) => emit(AuthSuccessState()),
      error: (failure) => emit(AuthErrorState(failure.errorMessage)),
    );
  }

  Future<void> _loginWithFacebook() async {
    emit(AuthLoadingState());
    final result = await _loginUseCase.call();

    result.when(
      success: (user) => emit(AuthSuccessState()),
      error: (failure) => emit(AuthErrorState(failure.errorMessage)),
    );
  }
}
