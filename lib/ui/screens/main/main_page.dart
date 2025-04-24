import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathef/ui/screens/home/home_page.dart';
import 'package:wathef/ui/screens/liked/liked_page.dart';
import 'package:wathef/ui/screens/main/main_cubit.dart';
import 'package:wathef/ui/screens/search/search_page.dart';
import 'package:wathef/ui/screens/setting/setting_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: MainPageChild(),
    );
  }
}

class MainPageChild extends StatelessWidget {
  const MainPageChild({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MainCubit>();
    return Scaffold(
      body: PageView(
        controller: cubit.pageController,
        children: [
          HomePage(),
          SearchPage(),
          LikedPage(),
          SettingPage(),
        ],
      ),
      bottomNavigationBar: BlocBuilder<MainCubit, int>(builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state,
          onTap: (value) => cubit.changePage(value),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Liked',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Library',
            ),
          ],
        );
      }),
    );
  }
}
