import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wathef/core/extension/extension.dart';
import 'package:wathef/core/styles/app_colors.dart';
import 'package:wathef/router/app_router.dart';
import 'package:wathef/service/audio/audio_player_handler.dart';
import 'package:wathef/ui/screens/player/player_cubit.dart';
import 'package:wathef/ui/widgets/image/app_cache_image.dart';

import 'common.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final playerCubit = context.read<PlayerCubit>();

    return GestureDetector(
      onTap: () => context.push(AppRouter.player),
      child: StreamBuilder<QueueState>(
        stream: playerCubit.queueState,
        builder: (context, queueSnapshot) {
          final queueState = queueSnapshot.data;

          if (queueState == null || queueState.queue.isEmpty) {
            return const SizedBox();
          }

          final playingItem = queueState.queue[queueState.queueIndex ?? 0];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.lightBlue),
                ),
                child: Row(
                  spacing: 8,
                  children: [
                    AppCacheImage(
                      imageUrl: playingItem.artUri.toString(),
                      borderRadius: 4,
                      width: 48,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            playingItem.title,
                            style: context.textTheme.titleMedium?.w600,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            playingItem.artist ?? '',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.ink03,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder<PlaybackState>(
                      stream: playerCubit.playbackState,
                      builder: (context, snapshot) {
                        final playbackState = snapshot.data;
                        final isPlaying = playbackState?.playing ?? false;

                        return IconButton(
                          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                          onPressed: () => isPlaying ? playerCubit.pause() : playerCubit.play(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              StreamBuilder<PositionData>(
                stream: playerCubit.positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  if (positionData == null || positionData.duration.inSeconds == 0) {
                    return const SizedBox();
                  }

                  final progress =
                      positionData.position.inMilliseconds / positionData.duration.inMilliseconds;

                  return LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    color: AppColors.orange,
                    backgroundColor: AppColors.orange.withValues(alpha: 0.3),
                    minHeight: 3,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
