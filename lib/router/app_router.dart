import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wathef/models/feed_playlist/feed_playlist.dart';
import 'package:wathef/ui/screens/main/main_page.dart';
import 'package:wathef/ui/screens/player/player_page.dart';
import 'package:wathef/ui/screens/playlist_detail/playlist_detail_page.dart';

class AppRouter {
  static const String home = '/';
  static const String playlistDetail = '/playlistDetail';
  static const String player = '/player';

  static final router = GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned.fill(child: child),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(),
                ),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            path: home,
            builder: (context, state) => MainPage(),
          ),
          GoRoute(
            path: playlistDetail,
            builder: (context, state) => PlaylistDetailPage(
              playlist: state.extra as FeedPlaylist,
            ),
          ),
          GoRoute(
            path: player,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const PlayerPage(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.ease));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              );
            },
          ),
        ],
      ),
    ],
  );
}
