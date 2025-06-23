import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/modules/profile/ui/widgets/custom_row_btn.dart';
import 'package:market_app/shared/functions/navigateTo.dart';

import '../../../models/user_model.dart';
import '../../../shared/components/custom_indicator.dart';
import '../../../shared/functions/navigate_to_without_back.dart';
import '../../../shared/styles/style.dart';
import '../../auth/logic/authentication_cubit.dart';
import '../../auth/login_screen/login_screen.dart';
import 'edit_name_screen.dart';
import 'my_orders_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (BuildContext context, state) {
        if (state is SignOutSuccess) {
          navigateToWithoutBack(context, screen: LoginScreen());
        }
      },
      builder: (BuildContext context, state) {
        UserDataModel? user = AuthenticationCubit.get(context).userDataModel;
        AuthenticationCubit cubit = AuthenticationCubit.get(context);
        return state is SignOutLoading
            ? CustomCircularIndicator()
            : Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Card(
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
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: AppColors.kPrimaryColor,
                            foregroundColor: AppColors.kWhiteColor,
                            child: Icon(Icons.person, size: 45),
                          ),
                          SizedBox(height: 10),
                          Text(
                            user!.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(user.email),
                          SizedBox(height: 10),
                          CustomProBtn(
                            label: 'Edit Name',
                            onPressed: () {
                              navigateTo(context, EditNameScreen());
                            },
                            icon: Icons.person,
                          ),
                          SizedBox(height: 10),
                          CustomProBtn(
                            label: 'My Orders',
                            onPressed: () {
                              navigateTo(context, MyOrdersScreen());
                            },
                            icon: Icons.shopping_basket_outlined,
                          ),
                          SizedBox(height: 10),
                          CustomProBtn(
                            label: 'LogOut',
                            onPressed: () {
                              cubit.signOut();
                            },
                            icon: Icons.logout_outlined,
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
