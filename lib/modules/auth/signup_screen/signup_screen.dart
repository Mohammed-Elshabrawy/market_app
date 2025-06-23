import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/shared/functions/navigate_to_without_back.dart';

import '../../../layout/navbar/ui/main_home_screen.dart';
import '../../../shared/components/custom_btn.dart';
import '../../../shared/components/custom_text_filed.dart';
import '../../../shared/functions/navigateTo.dart';
import '../../../shared/functions/showMsg.dart';
import '../../../shared/styles/style.dart';
import '../logic/authentication_cubit.dart';
import '../login_screen/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupNameController = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    signupNameController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationCubit cubit = AuthenticationCubit.get(context);
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (BuildContext context, state) {
        if (state is SignUpSuccess) {
          navigateToWithoutBack(context, screen: MainHomeScreen());
        } else if (state is SignUpError) {
          showMsg(context, text: state.message);
        }
      },
      builder: (BuildContext context, state) {
        return Scaffold(
          body: state is SignUpLoading || state is UserDataAddedLoading
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: signupFormKey,
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
                                    'SignUp',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  CustomTextFormFiled(
                                    onChange: (v) {
                                      if (v.isEmpty || v.length < 6) {
                                        cubit.changeIsSignUpNameValid(false);
                                      } else {
                                        cubit.changeIsSignUpNameValid(true);
                                      }
                                    },
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: AppColors.kBorderSideColor,
                                        width: 2,
                                      ),
                                    ),
                                    controller: signupNameController,
                                    type: TextInputType.name,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'please confirm your name';
                                      } else if (value.length < 6) {
                                        return 'please enter a valid name';
                                      }
                                      return null;
                                    },
                                    label: 'Name',
                                    prefix: Icon(
                                      Icons.person,
                                      color: cubit.isSignUpNameValid == true
                                          ? AppColors.kPrimaryColor
                                          : AppColors.kGreyColor,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  CustomTextFormFiled(
                                    onChange: (v) {
                                      final regex = RegExp(r"[^@]+@[^.]+\..+");
                                      if (!regex.hasMatch(v) || v.length < 6) {
                                        cubit.changeIsSignUpEmailValid(false);
                                      } else {
                                        cubit.changeIsSignUpEmailValid(true);
                                      }
                                    },
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: AppColors.kBorderSideColor,
                                        width: 2,
                                      ),
                                    ),
                                    controller: signupEmailController,
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
                                      color: cubit.isSignUpEmailValid
                                          ? AppColors.kPrimaryColor
                                          : AppColors.kGreyColor,
                                    ),
                                    obSecureText: false,
                                  ),
                                  SizedBox(height: 16),
                                  CustomTextFormFiled(
                                    onChange: (v) {
                                      if (v.isEmpty || v.length < 6) {
                                        cubit.changeIsSignUpPasswordValid(
                                          false,
                                        );
                                      } else {
                                        cubit.changeIsSignUpPasswordValid(true);
                                      }
                                    },
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: AppColors.kBorderSideColor,
                                        width: 2,
                                      ),
                                    ),
                                    controller: signupPasswordController,
                                    type: TextInputType.visiblePassword,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'please enter your password';
                                      }
                                      return null;
                                    },
                                    obSecureText: cubit.isPasswordSignUp,
                                    label: 'Password',
                                    prefix: Icon(
                                      Icons.password,
                                      color: cubit.isSignUpPasswordValid
                                          ? AppColors.kPrimaryColor
                                          : AppColors.kGreyColor,
                                    ),
                                    suffix: IconButton(
                                      onPressed: () {
                                        cubit.changeSignUpPasswordVisibility();
                                      },
                                      icon: Icon(
                                        cubit.isPasswordSignUp
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: cubit.isPasswordSignUp
                                            ? AppColors.kGreyColor
                                            : AppColors.kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    child: CustomBtn(
                                      text: 'Signup',
                                      onPressed: () {
                                        if (signupFormKey.currentState!
                                            .validate()) {
                                          cubit.register(
                                            name: signupNameController.text
                                                .trim(),
                                            email: signupEmailController.text
                                                .trim(),
                                            password: signupPasswordController
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
                                      text: "Signup with Google",
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "already have an account?",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          navigateTo(context, LoginScreen());
                                        },
                                        child: Text(
                                          "Login",
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
