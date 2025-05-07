import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathef/core/styles/app_theme.dart';
import 'package:wathef/repositories/track_repository.dart';
import 'package:wathef/router/app_router.dart';
import 'package:wathef/service/audio/audio_player_handler.dart';
import 'package:wathef/ui/screens/player/player_cubit.dart';

import 'locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PlayerCubit(
            trackRepository: locator<TrackRepository>(),
            audioHandler: locator<AudioPlayerHandler>(),
          ),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
