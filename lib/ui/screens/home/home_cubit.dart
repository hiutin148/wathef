import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathef/models/artist/artist.dart';
import 'package:wathef/models/enums/load_status.dart';
import 'package:wathef/repositories/feeds_repository.dart';

import '../../../models/feed_playlist/feed_playlist.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FeedsRepository feedsRepository;

  HomeCubit({required this.feedsRepository}) : super(const HomeState());

  Future<void> fetchFeeds() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      final [playlistResponse, artistResponse] = await Future.wait([
        feedsRepository.getFeedPlaylists(),
        feedsRepository.getFeedArtists(),
      ]);

      emit(state.copyWith(
        loadStatus: LoadStatus.success,
        playlists: playlistResponse.results.cast<FeedPlaylist>(),
        artists: artistResponse.results.cast<Artist>(),
      ));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }
}
