import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/custom_btn.dart';
import '../../../shared/components/custom_text_filed.dart';
import '../../../shared/functions/showMsg.dart';
import '../../../shared/styles/style.dart';
import '../logic/authentication_cubit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (BuildContext context, state) {
        if (state is ForgotPasswordSuccess) {
          Navigator.pop(context);
          showMsg(context, text: 'Email sent successfully');
        } else if (state is ForgotPasswordError) {
          showMsg(context, text: state.message);
        }
      },
      builder: (BuildContext context, state) {
        var cubit = AuthenticationCubit.get(context);
        return Scaffold(
          body: state is ForgotPasswordLoading
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Form(
                    key: forgotPasswordFormKey,
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Enter Your Email Address to reset your password',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
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
                                CustomTextFormFiled(
                                  onChange: (v) {
                                    final regex = RegExp(r"[^@]+@[^.]+\..+");
                                    if (!regex.hasMatch(v) || v.length < 6) {
                                      cubit.changeIsForgotPasswordEmailValid(
                                        false,
                                      );
                                    } else {
                                      cubit.changeIsForgotPasswordEmailValid(
                                        true,
                                      );
                                    }
                                  },
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: AppColors.kBorderSideColor,
                                      width: 2,
                                    ),
                                  ),
                                  controller: emailController,
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
                                    color: cubit.isForgotPasswordEmailValid
                                        ? AppColors.kPrimaryColor
                                        : AppColors.kBlackColor,
                                  ),
                                  obSecureText: false,
                                ),
                                SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  child: CustomBtn(
                                    text: 'Send',
                                    onPressed: () {
                                      if (forgotPasswordFormKey.currentState!
                                          .validate()) {
                                        cubit.resetPassword(
                                          email: emailController.text.trim(),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
