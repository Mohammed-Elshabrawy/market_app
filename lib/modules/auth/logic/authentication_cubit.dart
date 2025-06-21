import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  static AuthenticationCubit get(context) => BlocProvider.of(context);

  SupabaseClient clint = Supabase.instance.client;

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();


  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupNameController = TextEditingController();

  TextEditingController forgetPasswordEmailController = TextEditingController();

  bool isPassword = false;
  bool isPasswordSignUp = false;
  bool isLoginEmailValid = false;
  bool isLoginPasswordValid = false;
  bool isSignUpEmailValid = false;
  bool isSignUpPasswordValid = false;
  bool isSignUpNameValid = false;

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
      emit(LoginSuccess());
    } on AuthException catch (e) {
      log(e.message);
      emit(LoginError(message: e.message));
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
  Future<void> register({required String name, required String email, required String password}) async {
    emit(SingUpLoading());
    try {
      await clint.auth.signUp(password: password,email: email,);
      emit(SingUpSuccess());
    } on AuthException catch (e) {
      log(e.message);
      emit(SingUpError(message: e.message));
    } catch (e) {
      emit(SingUpError(message: e.toString()));
    }
  }
}
