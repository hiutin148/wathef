import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wathef/core/consts/api_consts.dart';
import 'package:wathef/models/artist/artist.dart';
import 'package:wathef/models/feed_playlist/feed_playlist.dart';
import 'package:wathef/models/playlist/playlist.dart';
import 'package:wathef/models/response/api_list_response.dart';
import 'package:wathef/models/track/track.dart';

part 'api_client.g.dart';

typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class JamendoApiService {
  factory JamendoApiService(Dio dio, {String baseUrl, }) = _JamendoApiService;

  @GET("/tracks")
  Future<ApiListResponse<Track>> getPopularTracks({
    @Query("limit") int limit = 10,
    @Query("offset") int offset = 0,
    @Query("order") String order = 'popularity_total',
    @Query("imagesize") int imageSize = 200,
  });

  // Feed
  @GET("/feeds")
  Future<ApiListResponse<FeedPlaylist>> getFeedPlaylists({
    @Query("limit") int limit = 10,
    @Query("offset") int offset = 0,
    @Query("order") String order = 'position_asc',
    @Query("type") String type = 'playlist',
  });

  @GET("/feeds")
  Future<ApiListResponse<Artist>> getFeedArtists({
    @Query("limit") int limit = 10,
    @Query("offset") int offset = 0,
    @Query("order") String order = 'position_asc',
    @Query("type") String type = 'artist',
  });

  // Playlist
  @GET("/playlists")
  Future<ApiListResponse<Playlist>> getPlaylistById({
    @Query("id") required List<String> id,
  });

  @GET("/playlists/tracks")
  Future<ApiListResponse<Playlist>> getPlaylistTracksById({
    @Query("id") required List<String> id,
  });
}
