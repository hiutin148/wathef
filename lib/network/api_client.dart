import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wathef/core/consts/api_consts.dart';
import 'package:wathef/models/response/api_list_response.dart';
import 'package:wathef/models/track/track.dart';

part 'api_client.g.dart';

typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class JamendoApiService {
  factory JamendoApiService(Dio dio, {String baseUrl}) = _JamendoApiService;

  @GET("/tracks")
  Future<ApiListResponse<Track>> getPopularTracks({
    @Query("limit") int limit = 20,
    @Query("offset") int offset = 0,
    @Query("order") String order = 'popularity_total',
    @Query("imagesize") int imageSize = 200,
  });
}
