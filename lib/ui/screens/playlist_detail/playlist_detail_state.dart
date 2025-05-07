part of 'playlist_detail_cubit.dart';

class PlaylistDetailState extends Equatable {
  final LoadStatus loadDataStatus;
  final Playlist? playlist;
  final List<PlaylistTrack> tracks;

  const PlaylistDetailState({
    this.loadDataStatus = LoadStatus.initial,
    this.tracks = const [],
    this.playlist,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        tracks,
        playlist,
      ];

  PlaylistDetailState copyWith({
    LoadStatus? loadDataStatus,
    List<PlaylistTrack>? tracks,
    Playlist? playlist,
  }) {
    return PlaylistDetailState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      tracks: tracks ?? this.tracks,
      playlist: playlist ?? this.playlist,
    );
  }
}
