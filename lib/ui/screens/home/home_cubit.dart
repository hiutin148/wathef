import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wathef/models/enums/load_status.dart';
import 'package:wathef/repositories/track_repository.dart';


part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final TrackRepository apiService;
  HomeCubit({required this.apiService}) : super(const HomeState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
