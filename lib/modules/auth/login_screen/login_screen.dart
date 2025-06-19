import 'package:flutter/material.dart';
import '../../../shared/components/custom_btn.dart';
import '../../../shared/components/custom_text_filed.dart';
import '../../../shared/functions/navigateTo.dart';
import '../../../shared/styles/style.dart';
import '../../navbar/ui/main_home_screen.dart';
import '../forget_password_Screen/forgot_password_screen.dart';
import '../singnup_screen/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Center(
                child: Text(
                  'Welcome to Market App',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                        prefix: Icons.email, obSecureText: false,
                      ),
                      SizedBox(height: 16),
                      CustomTextFormFiled(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: AppColors.kBorderSideColor,
                            width: 2,
                          ),
                        ),
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your password';
                          }

                          return null;
                        },
                        obSecureText: true,
                        label: 'Password',
                        prefix: Icons.password,
                        suffix: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.visibility_off),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              navigateTo(context, ForgotPasswordScreen());
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
                        child: CustomBtn(text: 'Login', onPressed: () {}),
                      ),
                      SizedBox(height: 10),
                      Stack(
                        children: [
                          Divider(color: AppColors.kGreyColor, thickness: 2),
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
    );
  }
}
