part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus loadStatus;
  final List<Playlist> playlists;

  const HomeState({
    this.loadStatus = LoadStatus.initial,
    this.playlists = const [],
  });

  @override
  List<Object?> get props => [loadStatus, playlists];

  HomeState copyWith({
    LoadStatus? loadStatus,
    List<Playlist>? playlists,
  }) {
    return HomeState(
      loadStatus: loadStatus ?? this.loadStatus,
      playlists: playlists ?? this.playlists,
    );
  }
}
