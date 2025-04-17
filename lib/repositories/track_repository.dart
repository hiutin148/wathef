import 'package:wathef/models/response/api_list_response.dart';
import 'package:wathef/network/api_client.dart';

abstract class TrackRepository {
  Future<ApiListResponse> getTracks();
}

class TrackRepositoryImpl implements TrackRepository {
  final JamendoApiService apiService;

  TrackRepositoryImpl({required this.apiService});

  @override
  Future<ApiListResponse> getTracks() async {
    return apiService.getPopularTracks();
  }
}
