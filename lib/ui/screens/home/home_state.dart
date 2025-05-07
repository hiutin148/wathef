part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus loadStatus;
  final List<FeedPlaylist> playlists;
  final List<Artist> artists;

  const HomeState({
    this.loadStatus = LoadStatus.initial,
    this.playlists = const [],
    this.artists = const [],
  });

  @override
  List<Object?> get props => [
        loadStatus,
        playlists,
        artists,
      ];

  HomeState copyWith({
    LoadStatus? loadStatus,
    List<FeedPlaylist>? playlists,
    List<Artist>? artists,
  }) {
    return HomeState(
      loadStatus: loadStatus ?? this.loadStatus,
      playlists: playlists ?? this.playlists,
      artists: artists ?? this.artists,
    );
  }
}
