import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/custom_btn.dart';
import '../../../shared/components/custom_text_filed.dart';
import '../../../shared/functions/navigateTo.dart';
import '../../../shared/styles/style.dart';
import '../logic/authentication_cubit.dart';
import '../login_screen/login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationCubit cubit = AuthenticationCubit.get(context);
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return Scaffold(
          body: state is SingUpLoading
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: cubit.signupFormKey,
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
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: AppColors.kBorderSideColor,
                                        width: 2,
                                      ),
                                    ),
                                    controller: cubit.signupNameController,
                                    type: TextInputType.name,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'please confirm your name';
                                      }else if(value.length<6){
                                        return 'please enter a valid name';
                                      }
                                      return null;
                                    },
                                    label: 'Name',
                                    prefix: Icon(Icons.person),
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
                                    controller: cubit.signupEmailController,
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
                                    prefix: Icon(Icons.email),
                                    obSecureText: false,
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
                                    controller: cubit.signupPasswordController,
                                    type: TextInputType.visiblePassword,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'please enter your password';
                                      }

                                      return null;
                                    },
                                    obSecureText: true,
                                    label: 'Password',
                                    prefix: Icon(Icons.password),
                                    suffix: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.visibility_off),
                                    ),
                                  ),
                                  SizedBox(height: 16),

                                  SizedBox(
                                    width: double.infinity,
                                    child: CustomBtn(
                                      text: 'Signup',
                                      onPressed: () {},
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
