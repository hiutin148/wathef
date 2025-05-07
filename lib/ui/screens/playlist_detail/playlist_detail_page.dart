import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:wathef/core/extension/extension.dart';
import 'package:wathef/core/styles/app_colors.dart';
import 'package:wathef/locator.dart';
import 'package:wathef/models/feed_playlist/feed_playlist.dart';
import 'package:wathef/models/playlist_track/playlist_track.dart';
import 'package:wathef/repositories/playlist_repository.dart';
import 'package:wathef/router/app_router.dart';
import 'package:wathef/service/audio/audio_player_handler.dart';
import 'package:wathef/ui/widgets/image/app_cache_image.dart';

import 'playlist_detail_cubit.dart';

class PlaylistDetailPage extends StatelessWidget {
  const PlaylistDetailPage({
    super.key,
    required this.playlist,
  });

  final FeedPlaylist playlist;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PlaylistDetailCubit(playlistRepo: locator<PlaylistRepository>());
      },
      child: PlaylistDetailChildPage(
        playlist: playlist,
      ),
    );
  }
}

class PlaylistDetailChildPage extends StatefulWidget {
  const PlaylistDetailChildPage({super.key, required this.playlist});

  final FeedPlaylist playlist;

  @override
  State<PlaylistDetailChildPage> createState() => _PlaylistDetailChildPageState();
}

class _PlaylistDetailChildPageState extends State<PlaylistDetailChildPage> {
  late final PlaylistDetailCubit _cubit;
  final double _appBarExpendedHeight = 427;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData(widget.playlist.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return CustomScrollView(
      slivers: [
        _buildAppBar(),
        _buildTrackList(),
      ],
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: _appBarExpendedHeight,
      pinned: true,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
          child: Stack(
            children: [
              Container(
                color: Colors.deepPurple[100],
                child: AppCacheImage(
                  imageUrl: widget.playlist.images?.size470x165 ?? '',
                ),
              ),
              // Title section
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.playlist.title?.en ?? '',
                        style: context.textTheme.headlineMedium?.w600,
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.playlist.text?.en ?? '',
                        style: context.textTheme.bodyMedium?.copyWith(color: AppColors.ink02),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackList() {
    return BlocSelector<PlaylistDetailCubit, PlaylistDetailState, List<PlaylistTrack>>(
      builder: (context, tracks) {
        return SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 42, horizontal: 45),
          sliver: SliverList.separated(
            itemCount: tracks.length,
            itemBuilder: (BuildContext context, int index) {
              final track = tracks[index];
              return PlaylistTrackItem(
                track: track,
                audioPlayerHandler: _cubit.audioPlayerHandler,
                onTap: () async {
                  await _cubit.playPlaylist(index);
                  if (context.mounted) {
                    context.push(AppRouter.player);
                  }
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 28,
              );
            },
          ),
        );
      },
      selector: (state) => state.tracks,
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}

class PlaylistTrackItem extends StatelessWidget {
  const PlaylistTrackItem(
      {super.key, required this.track, required this.audioPlayerHandler, required this.onTap});

  final PlaylistTrack track;
  final AudioPlayerHandler audioPlayerHandler;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QueueState>(
        stream: audioPlayerHandler.queueState,
        builder: (context, snapshot) {
          final currentQueue = snapshot.data?.queue ?? [];
          final currentIndex = snapshot.data?.queueIndex;
          bool isPlaying = false;
          if (currentIndex != null && currentQueue.isNotEmpty) {
            final currentPlaying = currentQueue[currentIndex];
            isPlaying = currentPlaying.id == track.audio;
          }
          return InkWell(
            onTap: onTap,
            child: Row(
              children: [
                AppCacheImage(
                  imageUrl: track.image,
                  width: 68,
                  height: 68,
                  borderRadius: 8,
                ),
                SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        track.name,
                        style: context.textTheme.bodyLarge?.w600,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        track.artistName,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.ink03,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isPlaying)
                  Align(
                    alignment: Alignment.center,
                    child: Lottie.asset(
                      'assets/lotties/music_playing.json',
                      width: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                PopupMenuButton<int>(
                  onSelected: (int item) {},
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                    const PopupMenuItem<int>(value: 0, child: Text('Item 1')),
                    const PopupMenuItem<int>(value: 1, child: Text('Item 2')),
                    const PopupMenuItem<int>(value: 2, child: Text('Item 3')),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
