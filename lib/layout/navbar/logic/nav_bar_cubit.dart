import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  static NavBarCubit get(context) => BlocProvider.of(context);

  NavBarCubit() : super(NavBarInitial());
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    emit(IndexChanged());
  }
}
