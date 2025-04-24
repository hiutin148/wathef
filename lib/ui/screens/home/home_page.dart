import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathef/core/extension/extension.dart';
import 'package:wathef/locator.dart';
import 'package:wathef/repositories/track_repository.dart';
import 'package:wathef/service/audio/audio_player_handler.dart';
import 'package:wathef/ui/widgets/buttons/app_text_button.dart';

import '../player/player_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PlayerCubit(trackRepository: locator<TrackRepository>(), audioHandler: locator<AudioPlayerHandler>())..loadInitialData();
      },
      child: const HomeChildPage(),
    );
  }
}

class HomeChildPage extends StatefulWidget {
  const HomeChildPage({super.key});

  @override
  State<HomeChildPage> createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<HomeChildPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goor morning Desta!'),
      ),
      body: Column(
        children: [
          Row(
            spacing: 12,
            children: [
              Expanded(child: Text('Made for you', style: context.textTheme.titleLarge?.w500)),
              AppTextButton(
                title: 'See all',
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
