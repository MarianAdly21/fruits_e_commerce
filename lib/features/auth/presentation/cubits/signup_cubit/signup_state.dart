part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoadingState extends SignupState {}

final class SignupErrorState extends SignupState {
  final String errorMessage;

  new({required this.errorMessage});
}

final class SignupSuccessState extends SignupState {
  final UserEntity userEntity;

  new({required this.userEntity});
}
