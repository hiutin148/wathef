import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathef/models/enums/load_status.dart';
import 'package:wathef/models/playlist/playlist.dart';
import 'package:wathef/repositories/feeds_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FeedsRepository feedsRepository;

  HomeCubit({required this.feedsRepository}) : super(HomeState());

  Future<void> fetchFeeds() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));

    final result = await feedsRepository.getFeedPlaylists();
    emit(state.copyWith(
      loadStatus: LoadStatus.success,
      playlists: result.results,
    ));
  }
}
