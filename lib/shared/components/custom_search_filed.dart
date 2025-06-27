import 'package:flutter/material.dart';

import '../styles/style.dart';

class CustomSearchFiled extends StatelessWidget {
  const CustomSearchFiled({
    super.key,
    required this.label,
    required this.searchFunction,
    required this.controller,
  });
  final String label;
  final Function()? searchFunction;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTap: () {},
      onChanged: (String value) {},
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kPrimaryColor,
            foregroundColor: AppColors.kWhiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: searchFunction,
          child: Icon(Icons.search),
        ), // Icon
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.kBorderSideColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.kBorderSideColor, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.kBorderSideColor, width: 2),
        ),
      ), // InputDecoration
    );
  }
}
