import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/models/user_model.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/network/remote/paymob.dart';
import '../../../shared/styles/style.dart';

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
      await getUserData();
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
      await getUserData();
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

  UserDataModel? userDataModel;
  Future<void> getUserData() async {
    emit(GetUserDataLoading());
    try {
      final data = await clint
          .from('users')
          .select()
          .eq('id', clint.auth.currentUser!.id);
      userDataModel = await UserDataModel(
        userId: data[0]['id'],
        name: data[0]['name'],
        email: data[0]['email'],
      );
      emit(GetUserDataSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetUserDataError(message: e.toString()));
    }
  }

  void createPayment() {
    PaymentData.initialize(
      apiKey:
          paymobApi, // Required: Found under Dashboard -> Settings -> Account Info -> API Key
      iframeId: paymobIFrame, // Required: Found under Developers -> iframes
      integrationCardId:
          paymobIntegrationCardId, // Required: Found under Developers -> Payment Integrations -> Online Card ID
      integrationMobileWalletId:
          paymobIntegrationMobileWalletId, // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID
      // Optional User Data
      /* userData: UserData(
        email: userDataModel!.email, // Optional: Defaults to 'NA'
        name: userDataModel!.name, // Optional: Defaults to 'NA'
      ),*/

      // Optional Style Customizations
      style: Style(
        primaryColor: AppColors.kPrimaryColor, // Default: Colors.blue
        scaffoldColor: AppColors.kWhiteColor, // Default: Colors.white
        appBarBackgroundColor: AppColors.kPrimaryColor, // Default: Colors.blue
        textStyle: TextStyle(), // Default: TextStyle()
        buttonStyle: ElevatedButton.styleFrom(
          foregroundColor: AppColors.kWhiteColor,
          backgroundColor: AppColors.kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ), // Default: ElevatedButton.styleFrom()
        circleProgressColor: AppColors.kPrimaryColor, // Default: Colors.blue
        unselectedColor: AppColors.kGreyColor, // Default: Colors.grey
      ),
    );
  }
}
