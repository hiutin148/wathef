import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathef/core/extension/extension.dart';
import 'package:wathef/locator.dart';
import 'package:wathef/service/audio/audio_player_handler.dart';
import 'package:wathef/ui/screens/home/home_page.dart';
import 'package:wathef/ui/screens/liked/liked_page.dart';
import 'package:wathef/ui/screens/main/main_cubit.dart';
import 'package:wathef/ui/screens/player/player_cubit.dart';
import 'package:wathef/ui/screens/search/search_page.dart';
import 'package:wathef/ui/screens/setting/setting_page.dart';
import 'package:wathef/ui/widgets/audio_player/common.dart';
import 'package:wathef/ui/widgets/image/app_cache_image.dart';

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
    return Stack(
      children: [
        Scaffold(
          body: PageView(
            controller: cubit.pageController,
            physics: NeverScrollableScrollPhysics(),
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
        ),
        Positioned(
          bottom: context.mediaQuery.padding.bottom + kBottomNavigationBarHeight,
          left: 0,
          right: 0,
          child: StreamBuilder<QueueState>(
              stream: locator<AudioPlayerHandler>().queueState,
              builder: (context, snapshot) {
                final queueState = snapshot.data;
                if (queueState != null) {
                  final playingItem = queueState.queue[queueState.queueIndex ?? 0];
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 60,
                        padding: EdgeInsets.all(6),
                        color: Colors.blue,
                        child: Row(
                          spacing: 8,
                          children: [
                            AppCacheImage(imageUrl: playingItem.artUri.toString()),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(playingItem.title),
                                Text(playingItem.artist ?? ''),
                              ],
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder<PositionData>(
                        stream: context.read<PlayerCubit>().positionDataStream,
                        builder: (context, snapshot) {
                          final positionData =
                              snapshot.data ?? PositionData(Duration.zero, Duration.zero, Duration.zero);
                          return SeekBar(
                            duration: positionData.duration,
                            position: positionData.position,
                            onChangeEnd: (newPosition) {
                              context.read<PlayerCubit>().audioHandler.seek(newPosition);
                            },
                          );
                        },
                      ),
                    ],
                  );
                }
                return SizedBox();
              }),
        ),
      ],
    );
  }
}
