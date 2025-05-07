import 'package:json_annotation/json_annotation.dart';
import 'package:wathef/models/playlist_track/playlist_track.dart';

part 'playlist.g.dart';

@JsonSerializable()
class Playlist {
  final String? id;
  final String? name;
  final String? creationdate;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'user_name')
  final String? userName;
  final String? zip;
  final String? shorturl;
  final String? shareurl;
  final List<PlaylistTrack>? tracks;

  Playlist({
    this.id,
    this.name,
    this.creationdate,
    this.userId,
    this.userName,
    this.zip,
    this.shorturl,
    this.shareurl,
    this.tracks,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistToJson(this);
}
