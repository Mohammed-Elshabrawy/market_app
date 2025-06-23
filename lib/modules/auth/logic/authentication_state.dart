part of 'authentication_cubit.dart';

sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class LoginLoading extends AuthenticationState {}

final class LoginSuccess extends AuthenticationState {}

final class LoginError extends AuthenticationState {
  final String message;
  LoginError({required this.message});
}

final class ChangeLoginPasswordVisibility extends AuthenticationState {}

final class SignUpLoading extends AuthenticationState {}

final class SignUpSuccess extends AuthenticationState {}

final class SignUpError extends AuthenticationState {
  final String message;
  SignUpError({required this.message});
}

final class ChangeSignUpPasswordVisibility extends AuthenticationState {}

final class UpdateIconValidation extends AuthenticationState {}

final class SignOutLoading extends AuthenticationState {}

final class SignOutSuccess extends AuthenticationState {}

final class SignOutError extends AuthenticationState {
  final String message;
  SignOutError({required this.message});
}

final class ForgotPasswordLoading extends AuthenticationState {}

final class ForgotPasswordSuccess extends AuthenticationState {}

final class ForgotPasswordError extends AuthenticationState {
  final String message;
  ForgotPasswordError({required this.message});
}

final class UserDataAddedLoading extends AuthenticationState {}
final class UserDataAddedSuccess extends AuthenticationState {}
final class UserDataAddedError extends AuthenticationState {
    final String message;
    UserDataAddedError({required this.message});
}

