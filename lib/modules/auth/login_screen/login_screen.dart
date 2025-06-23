import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/custom_btn.dart';
import '../../../shared/components/custom_indicator.dart';
import '../../../shared/components/custom_text_filed.dart';
import '../../../shared/functions/navigateTo.dart';
import '../../../shared/functions/navigate_to_without_back.dart';
import '../../../shared/functions/showMsg.dart';
import '../../../shared/styles/style.dart';
import '../../navbar/ui/main_home_screen.dart';
import '../forget_password_Screen/forgot_password_screen.dart';
import '../logic/authentication_cubit.dart';
import '../signup_screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (BuildContext context, state) {
        if (state is LoginSuccess) {
          navigateToWithoutBack(context, screen: MainHomeScreen());
        } else if (state is LoginError) {
          showMsg(context, state, text: state.message);
        }
      },
      builder: (BuildContext context, state) {
        AuthenticationCubit cubit = AuthenticationCubit.get(context);
        return Scaffold(
          body: state is LoginLoading
              ? CustomCircularIndicator()
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: cubit.loginFormKey,
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Center(
                            child: Text(
                              'Welcome to Market App',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Card(
                            margin: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              side: BorderSide(
                                color: AppColors.kBorderSideColor,
                                width: 1.0,
                              ),
                            ),
                            color: AppColors.kWhiteColor,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  CustomTextFormFiled(
                                    onChange: (v) {
                                      final regex = RegExp(r"[^@]+@[^.]+\..+");
                                      if (v.isEmpty || !regex.hasMatch(v)) {
                                        cubit.changeIsLoginEmailValid(false);
                                      } else {
                                        cubit.changeIsLoginEmailValid(true);
                                      }
                                    },
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: AppColors.kBorderSideColor,
                                        width: 2,
                                      ),
                                    ),
                                    controller: loginEmailController,
                                    type: TextInputType.emailAddress,
                                    validate: (String? value) {
                                      final regex = RegExp(r"[^@]+@[^.]+\..+");
                                      if (value!.isEmpty) {
                                        return 'please enter your email address';
                                      }
                                      if (!regex.hasMatch(value)) {
                                        return 'please enter a valid email address';
                                      }
                                      return null;
                                    },
                                    label: 'Email',
                                    prefix: Icon(
                                      Icons.email,
                                      color: cubit.isLoginEmailValid == true
                                          ? AppColors.kPrimaryColor
                                          : AppColors.kGreyColor,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  CustomTextFormFiled(
                                    onChange: (v) {
                                      if (v.isEmpty || v.length < 6) {
                                        cubit.changeIsLoginPasswordValid(false);
                                      } else {
                                        cubit.changeIsLoginPasswordValid(true);
                                      }
                                    },
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: AppColors.kBorderSideColor,
                                        width: 2,
                                      ),
                                    ),
                                    controller: loginPasswordController,
                                    type: TextInputType.visiblePassword,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'please enter your password';
                                      }
                                      if (value.length < 6) {
                                        return 'password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                    obSecureText: cubit.isPassword,
                                    label: 'Password',
                                    prefix: Icon(
                                      Icons.password,
                                      color: cubit.isLoginPasswordValid
                                          ? AppColors.kPrimaryColor
                                          : AppColors.kGreyColor,
                                    ),
                                    suffix: IconButton(
                                      onPressed:
                                          cubit.changeLoginPasswordVisibility,
                                      icon: Icon(
                                        cubit.isPassword == true
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: cubit.isPassword == true
                                            ? AppColors.kGreyColor
                                            : AppColors.kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          navigateTo(
                                            context,
                                            ForgotPasswordScreen(),
                                          );
                                        },
                                        child: Text(
                                          'Forget Password?',
                                          style: TextStyle(
                                            color: AppColors.kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    child: CustomBtn(
                                      text: 'Login',
                                      onPressed: () {
                                        if (cubit.loginFormKey.currentState!
                                            .validate()) {
                                          cubit.login(
                                            email: loginEmailController.text
                                                .trim(),
                                            password: loginPasswordController
                                                .text
                                                .trim(),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Stack(
                                    children: [
                                      Divider(
                                        color: AppColors.kGreyColor,
                                        thickness: 2,
                                      ),
                                      Center(
                                        child: Container(
                                          color: Colors.white,
                                          child: Text(
                                            "or",
                                            style: TextStyle(
                                              height: 0.5,
                                              color: AppColors.kGreyColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    width: double.infinity,
                                    child: CustomBtn(
                                      text: "Login with Google",
                                      onPressed: () {
                                        navigateTo(context, MainHomeScreen());
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account?",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          navigateTo(context, SignupScreen());
                                        },
                                        child: Text(
                                          "Sign Up",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
