import 'package:wathef/models/playlist/playlist.dart';
import 'package:wathef/models/response/api_list_response.dart';
import 'package:wathef/service/network/api_client.dart';

abstract class FeedsRepository {
  Future<ApiListResponse<Playlist>> getFeedPlaylists();
}

class FeedsRepositoryImpl implements FeedsRepository {
  final JamendoApiService apiService;

  FeedsRepositoryImpl({required this.apiService});

  @override
  Future<ApiListResponse<Playlist>> getFeedPlaylists() async {
    final result = await apiService.getFeedPlaylists();
    return result;
  }
}
