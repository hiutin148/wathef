import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:wathef/repositories/feeds_repository.dart';
import 'package:wathef/repositories/playlist_repository.dart';
import 'package:wathef/repositories/track_repository.dart';
import 'package:wathef/service/audio/audio_player_handler.dart';
import 'package:wathef/service/network/api_client.dart';
import 'package:wathef/service/network/dio_client.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandlerImpl(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.hiutin.wethef.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    ),
  );
  locator.registerSingleton<AudioPlayerHandler>(audioHandler);
  locator.registerLazySingleton<DioClient>(() => DioClient());
  locator.registerLazySingleton<JamendoApiService>(() => JamendoApiService(locator<DioClient>().dio));
  locator.registerLazySingleton<TrackRepository>(() => TrackRepositoryImpl(apiService: locator<JamendoApiService>()));
  locator.registerLazySingleton<FeedsRepository>(() => FeedsRepositoryImpl(apiService: locator<JamendoApiService>()));
  locator.registerLazySingleton<PlaylistRepository>(() => PlaylistRepositoryImpl(apiService: locator<JamendoApiService>()));
}
