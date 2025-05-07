import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathef/core/extension/extension.dart';
import 'package:wathef/core/styles/app_styles.dart';
import 'package:wathef/locator.dart';
import 'package:wathef/models/artist/artist.dart';
import 'package:wathef/repositories/feeds_repository.dart';
import 'package:wathef/ui/screens/home/home_cubit.dart';
import 'package:wathef/ui/widgets/buttons/app_text_button.dart';
import 'package:wathef/ui/widgets/image/app_cache_image.dart';
import 'package:wathef/ui/widgets/lavie_custom_scroll_view.dart';
import 'package:wathef/ui/widgets/playlist_card.dart';

import '../../../core/styles/app_colors.dart';
import '../../../models/feed_playlist/feed_playlist.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeCubit(feedsRepository: locator<FeedsRepository>());
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
  late final HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<HomeCubit>();
    _cubit.fetchFeeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Good morning Desta!'),
      ),
      body: LavieCustomScrollView(
        slivers: [
          _buildFeedPlaylists(),
          _buildPopularArtists(),
        ],
      ),
    );
  }

  Widget _buildFeedPlaylists() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          spacing: 16,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: Text(
                      'Playlists',
                      style: context.textTheme.titleLarge?.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 308,
              child: BlocSelector<HomeCubit, HomeState, List<FeedPlaylist>>(
                builder: (context, playlists) {
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final playlist = playlists[index];
                      return PlaylistCard(
                        playlist: playlist,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 16);
                    },
                    itemCount: playlists.length,
                  );
                },
                selector: (state) => state.playlists,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPopularArtists() {
    return SliverToBoxAdapter(
      child: Column(
        spacing: 12,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              spacing: 12,
              children: [
                Expanded(child: Text('Popular artists', style: context.textTheme.titleLarge?.w500)),
                AppTextButton(
                  title: 'See all',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: 220,
            child: BlocSelector<HomeCubit, HomeState, List<Artist>>(
              builder: (context, artists) {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final artist = artists[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 24),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            AppStyles.shadow1,
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppCacheImage(
                            imageUrl: artist.images.size470_165,
                            width: 150,
                            height: 150,
                            borderRadius: 75,
                            placeHolder: Container(
                              width: 150,
                              height: 150,
                              color: AppColors.getRandomPlaceHolderColor(),
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  size: 150 / 4,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            artist.title.en,
                            style: context.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600, height: 1.28),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 8);
                  },
                  itemCount: artists.length,
                );
              },
              selector: (state) => state.artists,
            ),
          )
        ],
      ),
    );
  }
}
