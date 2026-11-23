import 'package:bloc/bloc.dart';
import 'package:fruits_e_commerce/core/errors/failure.dart';
import 'package:fruits_e_commerce/features/auth/domain/entities/user_entity.dart';
import 'package:fruits_e_commerce/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authRepo}) : super(LoginInitial());
  final AuthRepo authRepo;

  Future<void> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    final result = await authRepo.signinWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(LoginErrorState(errorMessage: failure.message)),
      (userEntity) => emit(LoginSuccessState(userEntity: userEntity)),
    );
  }

  Future<void> signinWithGoogle() async {
    emit(LoginLoadingState());
    final result = await authRepo.signinWithGoogle();
    result.fold((failure) {
      if (failure is CancelledFailure) {
        return emit(LoginInitial());
      } else {
        return emit(LoginErrorState(errorMessage: failure.message));
      }
    }, (userEntity) => emit(LoginSuccessState(userEntity: userEntity)));
  }
}
