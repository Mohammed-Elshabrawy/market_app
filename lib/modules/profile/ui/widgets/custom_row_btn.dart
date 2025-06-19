import 'package:flutter/material.dart';

import '../../../../shared/styles/style.dart';
class CustomProBtn extends StatelessWidget {
  const CustomProBtn({super.key, required this.label,required this.onPressed,required this.icon});
  final String? label;
  final Function()? onPressed;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        color: AppColors.kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(color: AppColors.kBorderSideColor, width: 1.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(icon, color: AppColors.kWhiteColor),
              SizedBox(width: 10),
              Text(
                label!,
                style: TextStyle(color: AppColors.kWhiteColor, fontSize: 18,fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, color: AppColors.kWhiteColor),
            ],
          ),
        ),
      ),
    );
  }
}
