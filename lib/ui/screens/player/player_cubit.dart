import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wathef/models/enums/load_status.dart';
import 'package:wathef/repositories/track_repository.dart';
import 'package:wathef/service/audio/audio_player_handler.dart';
import 'package:wathef/ui/widgets/audio_player/common.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  final TrackRepository trackRepository;

  PlayerCubit({required this.trackRepository, required this.audioHandler}) : super(const PlayerState());
  final AudioPlayerHandler audioHandler;

  Stream<MediaItem?> get mediaItem => audioHandler.mediaItem;

  Stream<PlaybackState> get playbackState => audioHandler.playbackState;

  Stream<QueueState> get queueState => audioHandler.queueState;

  Stream<double> get volume => audioHandler.volume;

  Stream<double> get speed => audioHandler.speed;

  Stream<Duration> get bufferedPositionStream => audioHandler.playbackState.map((state) => state.bufferedPosition).distinct();

  Stream<Duration?> get durationStream => audioHandler.mediaItem.map((item) => item?.duration).distinct();

  Stream<PositionData> get positionDataStream => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        AudioService.position,
        bufferedPositionStream,
        durationStream,
        (position, buffered, duration) => PositionData(position, buffered, duration ?? Duration.zero),
      );

  void play() => audioHandler.play();

  void pause() => audioHandler.pause();

  void seek(Duration pos) => audioHandler.seek(pos);

  void skipToNext() => audioHandler.skipToNext();

  void skipToPrevious() => audioHandler.skipToPrevious();

  void skipToQueueItem(int index) => audioHandler.skipToQueueItem(index);

  void setVolume(double value) => audioHandler.setVolume(value);

  void setSpeed(double value) => audioHandler.setSpeed(value);

  void moveQueueItem(int oldIndex, int newIndex) => audioHandler.moveQueueItem(oldIndex, newIndex);

  void removeQueueItemAt(int index) => audioHandler.removeQueueItemAt(index);

  void setRepeatMode(AudioServiceRepeatMode mode) => audioHandler.setRepeatMode(mode);

  Future<void> setShuffleMode(AudioServiceShuffleMode mode) => audioHandler.setShuffleMode(mode);

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      // final response = await trackRepository.getTracks();
      // final mediaItems = response.results
      //     .map(
      //       (e) => MediaItem(id: e.audio, title: e.name, artUri: Uri.parse(e.image)),
      //     )
      //     .toList();
      // await audioHandler.updateQueue(mediaItems);
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
