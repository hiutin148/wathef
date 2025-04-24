part of 'liked_cubit.dart';

class LikedState extends Equatable {
  final LoadStatus loadDataStatus;

  const LikedState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  LikedState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return LikedState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
