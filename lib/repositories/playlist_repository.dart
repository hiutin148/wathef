import 'package:wathef/models/playlist/playlist.dart';
import 'package:wathef/models/playlist_track/playlist_track.dart';
import 'package:wathef/service/network/api_client.dart';

abstract class PlaylistRepository {
  Future<Playlist?> getPlayListById(String id);
  Future<List<PlaylistTrack>?> getPlayListTracksById(String id);
}

class PlaylistRepositoryImpl implements PlaylistRepository {
  final JamendoApiService apiService;

  PlaylistRepositoryImpl({required this.apiService});

  @override
  Future<Playlist?> getPlayListById(String id) async {
    final response = await apiService.getPlaylistById(id: [id]);
    return response.results.firstOrNull;
  }

  @override
  Future<List<PlaylistTrack>?> getPlayListTracksById(String id) async {
    final response = await apiService.getPlaylistTracksById(id: [id]);
    return response.results.firstOrNull?.tracks;
  }
}
