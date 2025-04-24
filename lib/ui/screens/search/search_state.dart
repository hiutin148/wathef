part of 'search_cubit.dart';

class SearchState extends Equatable {
  final LoadStatus loadDataStatus;

  const SearchState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  SearchState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return SearchState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
