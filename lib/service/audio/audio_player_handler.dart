import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class QueueState {
  static const QueueState empty = QueueState([], 0, [], AudioServiceRepeatMode.none);

  final List<MediaItem> queue;
  final int? queueIndex;
  final List<int>? shuffleIndices;
  final AudioServiceRepeatMode repeatMode;

  const QueueState(this.queue, this.queueIndex, this.shuffleIndices, this.repeatMode);

  bool get hasPrevious => repeatMode != AudioServiceRepeatMode.none || (queueIndex ?? 0) > 0;

  bool get hasNext => repeatMode != AudioServiceRepeatMode.none || (queueIndex ?? 0) + 1 < queue.length;

  List<int> get indices => shuffleIndices ?? List.generate(queue.length, (i) => i);
}

abstract class AudioPlayerHandler implements AudioHandler {
  Stream<QueueState> get queueState;

  Future<void> moveQueueItem(int currentIndex, int newIndex);

  ValueStream<double> get volume;

  Future<void> setVolume(double volume);

  ValueStream<double> get speed;
}

class AudioPlayerHandlerImpl extends BaseAudioHandler with SeekHandler implements AudioPlayerHandler {
  final BehaviorSubject<List<MediaItem>> _recentSubject = BehaviorSubject.seeded(<MediaItem>[]);
  final _mediaLibrary = MediaLibrary();
  final _player = AudioPlayer();

  late ConcatenatingAudioSource _playlist;
  @override
  final BehaviorSubject<double> volume = BehaviorSubject.seeded(1.0);
  @override
  final BehaviorSubject<double> speed = BehaviorSubject.seeded(1.0);
  final _mediaItemExpando = Expando<MediaItem>();

  // Stream<List<IndexedAudioSource>> get _effectiveSequence => Rx.combineLatest3<
  //     List<IndexedAudioSource>?,
  //     List<int>?,
  //     bool,
  //     List<IndexedAudioSource>?>(_player.sequenceStream,
  //     _player.shuffleIndicesStream, _player.shuffleModeEnabledStream,
  //         (sequence, shuffleIndices, shuffleModeEnabled) {
  //       if (sequence == null) return [];
  //       if (!shuffleModeEnabled) return sequence;
  //       if (shuffleIndices == null) return null;
  //
  //       if (sequence.isEmpty && shuffleIndices.isEmpty) return [];
  //       if (shuffleIndices.length != sequence.length) return null;
  //       return shuffleIndices.map((i) => sequence[i]).toList();
  //     }).whereType<List<IndexedAudioSource>>();

  int? getQueueIndex(int? currentIndex, bool shuffleModeEnabled, List<int>? shuffleIndices) {
    final effectiveIndices = _player.effectiveIndices;

    if (effectiveIndices.isEmpty || currentIndex == null) return null;

    if (!shuffleModeEnabled) {
      return (currentIndex >= 0 && currentIndex < effectiveIndices.length) ? currentIndex : null;
    } else {
      if (shuffleIndices == null || shuffleIndices.length != effectiveIndices.length) {
        return null;
      }

      final indexInShuffledList = shuffleIndices.indexOf(currentIndex);
      return (indexInShuffledList != -1) ? indexInShuffledList : null;
    }
  }

  @override
  Stream<QueueState> get queueState => Rx.combineLatest3<List<MediaItem>, PlaybackState, List<int>?, QueueState>(queue, playbackState, _player.shuffleIndicesStream.startWith(const <int>[]), (queue, playbackState, shuffleIndices) {
        final useShuffleIndices = playbackState.shuffleMode == AudioServiceShuffleMode.all;

        final validShuffleIndices = (useShuffleIndices && shuffleIndices != null && shuffleIndices.isNotEmpty && shuffleIndices.length == queue.length) ? shuffleIndices : null;

        return QueueState(
          queue,
          playbackState.queueIndex,
          validShuffleIndices,
          playbackState.repeatMode,
        );
      });

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    final enabled = shuffleMode == AudioServiceShuffleMode.all;
    if (enabled) {
      if (_player.sequence.isNotEmpty) {
        await _player.shuffle();
      }
    }

    await _player.setShuffleModeEnabled(enabled);

    playbackState.add(playbackState.value.copyWith(shuffleMode: shuffleMode));
    _broadcastState(_player.playbackEvent);
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    playbackState.add(playbackState.value.copyWith(repeatMode: repeatMode));
    await _player.setLoopMode(LoopMode.values[repeatMode.index]);
    _broadcastState(_player.playbackEvent);
  }

  @override
  Future<void> setSpeed(double speed) async {
    this.speed.add(speed);
    await _player.setSpeed(speed);
  }

  @override
  Future<void> setVolume(double volume) async {
    this.volume.add(volume);
    await _player.setVolume(volume);
  }

  AudioPlayerHandlerImpl() {
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    final initialMediaItems = _mediaLibrary.items[MediaLibrary.albumsRootId]!;

    final initialAudioSources = initialMediaItems.map(_itemToSource).toList();
    _playlist = ConcatenatingAudioSource(children: initialAudioSources);

    speed.debounceTime(const Duration(milliseconds: 250)).listen((speed) {
      playbackState.add(playbackState.value.copyWith(speed: speed));
    });

    mediaItem.whereType<MediaItem>().listen((item) => _recentSubject.add([item]));

    _player.currentIndexStream.listen((index) {
      final currentQueue = queue.value;
      final effectiveIndex = getQueueIndex(index, _player.shuffleModeEnabled, _player.shuffleIndices);
      if (effectiveIndex != null && effectiveIndex < currentQueue.length) {
        mediaItem.add(currentQueue[effectiveIndex]);
      } else {
        mediaItem.add(null);
      }
    });

    _player.playbackEventStream.listen(_broadcastState);

    _player.shuffleModeEnabledStream.listen((enabled) => _broadcastState(_player.playbackEvent));

    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        if (playbackState.value.repeatMode != AudioServiceRepeatMode.all) {
          stop();
          _player.seek(Duration.zero, index: 0);
        }
      }
    });

    _player.sequenceStream
        .map((sequence) => sequence.map((source) {
              final item = _mediaItemExpando[source];

              return item ?? MediaItem(id: 'error-${source.hashCode}', title: 'Unknown');
            }).toList())
        .pipe(queue);

    try {
      await _player.setAudioSource(_playlist, initialIndex: 0, preload: true);
    } catch (e) {
      print("Error setting initial audio source: $e");
    }
  }

  AudioSource _itemToSource(MediaItem mediaItem) {
    Uri? uri;
    try {
      uri = Uri.parse(mediaItem.id);
    } catch (e) {
      print("Error parsing URI for MediaItem ID: ${mediaItem.id}, Error: $e");

      throw ArgumentError("Invalid URI in MediaItem ID: ${mediaItem.id}");
    }
    final audioSource = AudioSource.uri(uri);

    _mediaItemExpando[audioSource] = mediaItem;
    return audioSource;
  }

  List<AudioSource> _itemsToSources(List<MediaItem> mediaItems) => mediaItems.map(_itemToSource).toList();

  @override
  Future<List<MediaItem>> getChildren(String parentMediaId, [Map<String, dynamic>? options]) async {
    switch (parentMediaId) {
      case AudioService.recentRootId:
        return _recentSubject.value;
      default:
        return _mediaLibrary.items[parentMediaId] ?? [];
    }
  }

  @override
  ValueStream<Map<String, dynamic>> subscribeToChildren(String parentMediaId) {
    switch (parentMediaId) {
      case AudioService.recentRootId:
        final stream = _recentSubject.map((_) => <String, dynamic>{});
        return stream.shareValueSeeded(<String, dynamic>{});
      default:
        final items = _mediaLibrary.items[parentMediaId] ?? [];
        return BehaviorSubject.seeded(items).map((_) => <String, dynamic>{}).shareValueSeeded(<String, dynamic>{});
    }
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    final source = _itemToSource(mediaItem);
    await _playlist.add(source);
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    final sources = _itemsToSources(mediaItems);
    await _playlist.addAll(sources);
  }

  @override
  Future<void> insertQueueItem(int index, MediaItem mediaItem) async {
    final source = _itemToSource(mediaItem);
    await _playlist.insert(index, source);
  }

  @override
  Future<void> updateQueue(List<MediaItem> queue) async {
    await _player.stop();
    await _playlist.clear();

    final newSources = _itemsToSources(queue);

    await _playlist.addAll(newSources);
  }

  @override
  Future<void> updateMediaItem(MediaItem mediaItem) async {
    final index = queue.value.indexWhere((item) => item.id == mediaItem.id);
    if (index == -1) {
      return;
    }

    final playerSequence = _player.sequence;
    if (index >= playerSequence.length) {
      return;
    }
    final audioSource = playerSequence[index];

    _mediaItemExpando[audioSource] = mediaItem;

    int? originalIndex = _player.currentIndex;

    if (originalIndex == index) {
      this.mediaItem.add(mediaItem);
    }

    final currentQueueItems = playerSequence.map((s) => _mediaItemExpando[s] ?? MediaItem(id: 'error-${s.hashCode}', title: 'Unknown')).toList();
    queue.add(currentQueueItems);
  }

  @override
  Future<void> removeQueueItem(MediaItem mediaItem) async {
    final index = queue.value.indexWhere((item) => item.id == mediaItem.id);
    if (index != -1) {
      try {
        if (index < _playlist.length) {
          await _playlist.removeAt(index);
        } else {
          print("Error removing item: Index $index out of bounds for playlist length ${_playlist.length}");
        }
      } catch (e) {
        print("Error removing item at index $index: $e");
      }
    }
  }

  @override
  Future<void> moveQueueItem(int currentIndex, int newIndex) async {
    if (currentIndex >= 0 && currentIndex < _playlist.length && newIndex >= 0 && newIndex < _playlist.length) {
      await _playlist.move(currentIndex, newIndex);
    } else {
      print("Error moving item: Invalid indices ($currentIndex, $newIndex) for playlist length ${_playlist.length}");
    }
  }

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= queue.value.length) return;

    _player.seek(Duration.zero, index: index);
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() async {
    await _player.stop();
  }

  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;

    final currentItemIndex = event.currentIndex;
    final effectiveQueueIndex = getQueueIndex(currentItemIndex, _player.shuffleModeEnabled, _player.shuffleIndices);

    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
        MediaAction.setShuffleMode,
        MediaAction.setRepeatMode,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: effectiveQueueIndex,
      shuffleMode: _player.shuffleModeEnabled ? AudioServiceShuffleMode.all : AudioServiceShuffleMode.none,
      repeatMode: AudioServiceRepeatMode.values[_player.loopMode.index],
    ));
  }
}

/// Provides access to a library of media items. In your app, this could come
/// from a database or web service.
class MediaLibrary {
  static const albumsRootId = 'albums';

  final items = <String, List<MediaItem>>{
    AudioService.browsableRootId: const [
      MediaItem(
        id: albumsRootId,
        title: "Albums",
        playable: false,
      ),
    ],
    albumsRootId: [
      MediaItem(
        id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
        album: "Science Friday",
        title: "A Salute To Head-Scratching Science",
        artist: "Science Friday and WNYC Studios",
        duration: const Duration(milliseconds: 5739820),
        artUri: Uri.parse('https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
      ),
      MediaItem(
        id: 'https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3',
        album: "Science Friday",
        title: "From Cat Rheology To Operatic Incompetence",
        artist: "Science Friday and WNYC Studios",
        duration: const Duration(milliseconds: 2856950),
        artUri: Uri.parse('https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
      ),
      MediaItem(
        id: 'https://s3.amazonaws.com/scifri-segments/scifri202011274.mp3',
        album: "Science Friday",
        title: "Laugh Along At Home With The Ig Nobel Awards",
        artist: "Science Friday and WNYC Studios",
        duration: const Duration(milliseconds: 1791883),
        artUri: Uri.parse('https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
      ),
    ],
  };
}
