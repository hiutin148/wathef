import 'package:wathef/models/response/api_list_response.dart';
import 'package:wathef/models/track/track.dart';
import 'package:wathef/service/network/api_client.dart';

abstract class TrackRepository {
  Future<ApiListResponse<Track>> getTracks();
}

class TrackRepositoryImpl implements TrackRepository {
  final JamendoApiService apiService;

  TrackRepositoryImpl({required this.apiService});

  @override
  Future<ApiListResponse<Track>> getTracks() async {
    final result = await apiService.getPopularTracks();
    return result;
  }
}
