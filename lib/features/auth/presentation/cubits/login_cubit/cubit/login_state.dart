part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginErrorState extends LoginState {
  final String errorMessage;

  new({required this.errorMessage});
}

final class LoginSuccessState extends LoginState {
  final UserEntity userEntity;

  new({required this.userEntity});
}
