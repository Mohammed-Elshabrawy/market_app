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

final class SingUpLoading extends AuthenticationState {}
final class SingUpSuccess extends AuthenticationState {}
final class SingUpError extends AuthenticationState {
  final String message;
  SingUpError({required this.message});
}

