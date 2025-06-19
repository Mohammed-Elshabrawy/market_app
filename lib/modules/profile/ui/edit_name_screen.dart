import 'package:flutter/material.dart';

import '../../../shared/components/custom_btn.dart';
import '../../../shared/components/custom_text_filed.dart';
import '../../../shared/functions/build_custom_app_bar.dart';
import '../../../shared/styles/style.dart';

class EditNameScreen extends StatelessWidget {
  const EditNameScreen({super.key});

  static TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, label: 'Edit Name'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DefaultFormFiled(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppColors.kBorderSideColor,
                  width: 2,
                ),
              ),
              controller: nameController,
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'name must not be empty';
                }
                return null;
              },
              label: 'Enter Your New Name',
              obSecureText: false,
              type: TextInputType.text,
            ),
            SizedBox(height: 20),
            DefaultButton(text: 'Update'),
          ],
        ),
      ),
    );
  }
}
