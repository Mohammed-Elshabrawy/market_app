import 'package:flutter/material.dart';
import '../../../shared/components/custom_btn.dart';
import '../../../shared/components/custom_text_filed.dart';
import '../../../shared/styles/style.dart';
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});
  static TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Enter Your Email Address to reset your password',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 30),
            Card(
              margin: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: BorderSide(color: AppColors.kBorderSideColor, width: 1.0),
              ),
              color: AppColors.kWhiteColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    defaultFormFiled(
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
                      prefix: Icons.email,
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: defaultButton(text: 'Send', onPressed: () {}),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}