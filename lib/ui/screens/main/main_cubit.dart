import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<int> {
  MainCubit() : super(0);
  final PageController pageController = PageController();

  void changePage(int index) {
    emit(index);
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeIn,
    );
  }
}
