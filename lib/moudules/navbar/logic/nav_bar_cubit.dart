import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../favorite/ui/fav_screen.dart';
import '../../home/ui/home_screen.dart';
import '../../profile/ui/profile_screen.dart';
import '../../store/ui/store_screen.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  static NavBarCubit get(context) => BlocProvider.of(context);

  NavBarCubit() : super(NavBarInitial());
  int currentIndex = 0;
  final List<Widget> screens = [
    HomeScreen(),
    StoreScreen(),
    FavScreen(),
    ProfileScreen(),
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(IndexChanged());
  }
}
