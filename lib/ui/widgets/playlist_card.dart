import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wathef/core/extension/extension.dart';
import 'package:wathef/core/styles/app_colors.dart';
import 'package:wathef/router/app_router.dart';

import '../../core/styles/app_styles.dart';
import '../../models/feed_playlist/feed_playlist.dart';
import 'image/app_cache_image.dart';

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({super.key, required this.playlist});

  final FeedPlaylist playlist;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(AppRouter.playlistDetail, extra: playlist),
      child: Container(
        width: 254,
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            AppStyles.shadow1,
          ],
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      playlist.text?.en ?? '',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.ink02,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      playlist.title?.en ?? '',
                      style: context.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600, height: 1.28),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
