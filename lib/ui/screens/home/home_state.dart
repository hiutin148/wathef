part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<MediaItem> mediaItems;

  const HomeState({
    this.loadDataStatus = LoadStatus.initial,
    this.mediaItems = const [],
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        mediaItems,
      ];

  HomeState copyWith({
    LoadStatus? loadDataStatus,
    List<MediaItem>? mediaItems,
  }) {
    return HomeState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      mediaItems: mediaItems ?? this.mediaItems,
    );
  }
}
