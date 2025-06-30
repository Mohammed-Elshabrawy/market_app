import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:market_app/shared/styles/style.dart';

import '../../../modules/favorite/ui/fav_screen.dart';
import '../../../modules/home/ui/home_screen.dart';
import '../../../modules/profile/ui/profile_screen.dart';
import '../../../modules/store/ui/store_screen.dart';
import '../logic/nav_bar_cubit.dart';

class MainHomeScreen extends StatelessWidget {
  MainHomeScreen({super.key});
  final List<Widget> screens = [
    HomeScreen(),
    StoreScreen(),
    FavScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NavBarCubit(),
      child: BlocConsumer<NavBarCubit, NavBarState>(
        listener: (BuildContext context, NavBarState state) {},
        builder: (BuildContext context, NavBarState state) {
          NavBarCubit cubit = NavBarCubit.get(context);
          return Scaffold(
            body: screens[cubit.currentIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(color: AppColors.kWhiteColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 15,
                ),
                child: GNav(
                  selectedIndex: cubit.currentIndex,
                  onTabChange: (index) {
                    cubit.changeIndex(index);
                  },
                  rippleColor: AppColors.kPrimaryColor,
                  hoverColor: AppColors.kPrimaryColor,
                  gap: 8,
                  activeColor: AppColors.kWhiteColor,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: AppColors.kPrimaryColor,
                  color: AppColors.kGreyColor,
                  tabs: [
                    GButton(icon: Icons.home, text: 'Home'),
                    GButton(icon: Icons.store, text: 'Store'),
                    GButton(icon: Icons.favorite, text: 'Favorite'),
                    GButton(icon: Icons.person, text: 'Profile'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
