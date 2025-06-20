import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  static AuthenticationCubit get(context) => BlocProvider.of(context);

  SupabaseClient clint = Supabase.instance.client;

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupNameController = TextEditingController();
  TextEditingController forgetPasswordEmailController = TextEditingController();
  bool isPassword = false;

  void changeLoginPasswordVisibility() {
    isPassword = !isPassword;
    print(isPassword);
    emit(ChangeLoginPasswordVisibility());
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
}
