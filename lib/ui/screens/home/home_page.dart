import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathef/core/extension/extension.dart';
import 'package:wathef/locator.dart';
import 'package:wathef/models/playlist/playlist.dart';
import 'package:wathef/repositories/feeds_repository.dart';
import 'package:wathef/ui/screens/home/home_cubit.dart';
import 'package:wathef/ui/widgets/buttons/app_text_button.dart';
import 'package:wathef/ui/widgets/image/app_cache_image.dart';

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
      body: Column(
        spacing: 28,
        children: [
          _buildFeedPlaylists(),
          _buildPopularSinger(),
        ],
      ),
    );
  }

  Widget _buildFeedPlaylists() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
      child: Column(
        spacing: 16,
        children: [
          Row(
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
          SizedBox(
            height: 282,
            child: BlocSelector<HomeCubit, HomeState, List<Playlist>>(
              builder: (context, playlists) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final playlist = playlists[index];
                    return Container(
                      width: 254,
                      height: 282,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppCacheImage(
                            imageUrl: playlist.images?.size470x165 ?? '',
                            width: 254,
                            height: 200,
                            borderRadius: 8,
                          ),
                          Text(playlist.title?.en ?? ''),
                        ],
                      ),
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
    );
  }

  Widget _buildPopularSinger() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
      child: Column(
        spacing: 12,
        children: [
          Row(
            spacing: 12,
            children: [
              Expanded(
                  child: Text('Popular singer',
                      style: context.textTheme.titleLarge?.w500)),
              AppTextButton(
                title: 'See all',
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  width: 200,
                  height: 180,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemCount: 4,
            ),
          )
        ],
      ),
    );
  }
}
