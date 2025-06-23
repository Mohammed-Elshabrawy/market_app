import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  static AuthenticationCubit get(context) => BlocProvider.of(context);

  SupabaseClient clint = Supabase.instance.client;

  bool isPassword = true;
  bool isPasswordSignUp = true;
  bool isLoginEmailValid = false;
  bool isLoginPasswordValid = false;
  bool isSignUpEmailValid = false;
  bool isSignUpPasswordValid = false;
  bool isSignUpNameValid = false;
  bool isForgotPasswordEmailValid = false;

  void changeIsForgotPasswordEmailValid(bool value) {
    isForgotPasswordEmailValid = value;
    emit(UpdateIconValidation());
  }

  void changeLoginPasswordVisibility() {
    isPassword = !isPassword;
    emit(ChangeLoginPasswordVisibility());
  }

  void changeSignUpPasswordVisibility() {
    isPasswordSignUp = !isPasswordSignUp;
    emit(ChangeSignUpPasswordVisibility());
  }

  void changeIsLoginEmailValid(bool newValue) {
    isLoginEmailValid = newValue;
    emit(UpdateIconValidation());
  }

  void changeIsLoginPasswordValid(bool newValue) {
    isLoginPasswordValid = newValue;
    emit(UpdateIconValidation());
  }

  void changeIsSignUpEmailValid(bool newValue) {
    isSignUpEmailValid = newValue;
    emit(UpdateIconValidation());
  }

  void changeIsSignUpPasswordValid(bool newValue) {
    isSignUpPasswordValid = newValue;
    emit(UpdateIconValidation());
  }

  void changeIsSignUpNameValid(bool newValue) {
    isSignUpNameValid = newValue;
    emit(UpdateIconValidation());
  }

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await clint.auth.signInWithPassword(password: password, email: email);
      changeIsLoginEmailValid(false);
      changeIsLoginPasswordValid(false);
      emit(LoginSuccess());
    } on AuthException catch (e) {
      log(e.message);
      emit(LoginError(message: e.message));
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    try {
      await clint.auth.signUp(password: password, email: email);
      changeIsSignUpEmailValid(false);
      changeIsSignUpPasswordValid(false);
      changeIsSignUpNameValid(false);
      await addUserData(name: name, email: email);
      emit(SignUpSuccess());
    } on AuthException catch (e) {
      log(e.message);
      emit(SignUpError(message: e.message));
    } catch (e) {
      emit(SignUpError(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(SignOutLoading());
    try {
      await clint.auth.signOut();
      emit(SignOutSuccess());
    } on AuthException catch (e) {
      log(e.message);
      emit(SignOutError(message: e.message));
    } catch (e) {
      emit(SignOutError(message: e.toString()));
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(ForgotPasswordLoading());
    try {
      await clint.auth.resetPasswordForEmail(email);
      changeIsForgotPasswordEmailValid(false);
      emit(ForgotPasswordSuccess());
    } catch (e) {
      log(e.toString());
      emit(ForgotPasswordError(message: e.toString()));
    }
  }

  Future<void> addUserData({
    required String name,
    required String email,
  }) async {
    emit(UserDataAddedLoading());
    try {
      await clint.from('users').upsert({
        'id': clint.auth.currentUser!.id,
        'name': name,
        'email': email,
      });
      emit(UserDataAddedSuccess());
    } catch (e) {
      log(e.toString());
      emit(UserDataAddedError(message: e.toString()));
    }
  }
}
