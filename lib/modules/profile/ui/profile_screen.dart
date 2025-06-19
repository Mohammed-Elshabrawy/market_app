import 'package:flutter/material.dart';
import 'package:market_app/modules/profile/ui/widgets/custom_row_btn.dart';
import 'package:market_app/shared/functions/navigateTo.dart';

import '../../../shared/styles/style.dart';
import 'edit_name_screen.dart';
import 'my_orders_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height*0.65,
        child: Card(
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
                CircleAvatar(
                  radius: 55,
                  backgroundColor: AppColors.kPrimaryColor,
                  foregroundColor: AppColors.kWhiteColor,
                  child: Icon(Icons.person, size: 45),
                ),

                SizedBox(height: 10),
                Text(
                  "User Name",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text("User Email", style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                CustomProBtn(label: 'Edit Name', onPressed: () {navigateTo(context, EditNameScreen()); }, icon: Icons.person,),
                SizedBox(height: 10),
                CustomProBtn(label: 'My Orders', onPressed: () {navigateTo(context, MyOrdersScreen());  }, icon: Icons.shopping_basket_outlined,),
                SizedBox(height: 10),
                CustomProBtn(label: 'LogOut', onPressed: () {  }, icon: Icons.logout_outlined,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

