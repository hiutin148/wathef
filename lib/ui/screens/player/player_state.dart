part of 'player_cubit.dart';

class PlayerState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<MediaItem> mediaItems;

  const PlayerState({
    this.loadDataStatus = LoadStatus.initial,
    this.mediaItems = const [],
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        mediaItems,
      ];

  PlayerState copyWith({
    LoadStatus? loadDataStatus,
    List<MediaItem>? mediaItems,
  }) {
    return PlayerState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      mediaItems: mediaItems ?? this.mediaItems,
    );
  }
}
