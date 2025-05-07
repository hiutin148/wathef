import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wathef/locator.dart';
import 'package:wathef/models/enums/load_status.dart';
import 'package:wathef/models/playlist/playlist.dart';
import 'package:wathef/models/playlist_track/playlist_track.dart';
import 'package:wathef/repositories/playlist_repository.dart';
import 'package:wathef/service/audio/audio_player_handler.dart';

part 'playlist_detail_state.dart';

class PlaylistDetailCubit extends Cubit<PlaylistDetailState> {
  final PlaylistRepository playlistRepo;
  final AudioPlayerHandler audioPlayerHandler = locator<AudioPlayerHandler>();

  PlaylistDetailCubit({required this.playlistRepo}) : super(const PlaylistDetailState());

  Future<void> loadInitialData(String id) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      final [playlist, tracks] = await Future.wait([
        playlistRepo.getPlayListById(id),
        playlistRepo.getPlayListTracksById(id),
      ]);
      if (playlist == null || tracks == null) {
        emit(state.copyWith(loadDataStatus: LoadStatus.failure));
      } else {
        emit(state.copyWith(
          loadDataStatus: LoadStatus.success,
          playlist: playlist as Playlist,
          tracks: tracks as List<PlaylistTrack>,
        ));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<void> playPlaylist(int index) async {
    await audioPlayerHandler.updateQueue(state.tracks
        .map(
          (track) => MediaItem(
            id: track.audio,
            title: track.name,
            artUri: Uri.parse(track.image),
            artist: track.artistName,
            duration: Duration(seconds: int.tryParse(track.duration) ?? 0),
          ),
        )
        .toList());
    audioPlayerHandler.skipToQueueItem(index);
    audioPlayerHandler.play();
  }
}
