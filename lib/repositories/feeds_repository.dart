import 'package:wathef/models/artist/artist.dart';
import 'package:wathef/models/feed_playlist/feed_playlist.dart';
import 'package:wathef/models/response/api_list_response.dart';
import 'package:wathef/service/network/api_client.dart';

abstract class FeedsRepository {
  Future<ApiListResponse<FeedPlaylist>> getFeedPlaylists();
  Future<ApiListResponse<Artist>> getFeedArtists();
}

class FeedsRepositoryImpl implements FeedsRepository {
  final JamendoApiService apiService;

  FeedsRepositoryImpl({required this.apiService});

  @override
  Future<ApiListResponse<FeedPlaylist>> getFeedPlaylists() async {
    final result = await apiService.getFeedPlaylists();
    return result;
  }

  @override
  Future<ApiListResponse<Artist>> getFeedArtists() async {
    final result = await apiService.getFeedArtists();
    return result;
  }
}
