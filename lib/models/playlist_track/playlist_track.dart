import 'package:json_annotation/json_annotation.dart';

part 'playlist_track.g.dart';

@JsonSerializable()
class PlaylistTrack {
  final String id;
  final String name;

  @JsonKey(name: 'album_id')
  final String albumId;

  @JsonKey(name: 'artist_id')
  final String artistId;

  final String duration;

  @JsonKey(name: 'artist_name')
  final String artistName;

  final String playlistadddate;
  final String position;

  @JsonKey(name: 'license_ccurl')
  final String licenseCcurl;

  @JsonKey(name: 'album_image')
  final String albumImage;

  final String image;
  final String audio;
  final String audiodownload;

  @JsonKey(name: 'audiodownload_allowed')
  final bool audiodownloadAllowed;

  PlaylistTrack({
    required this.id,
    required this.name,
    required this.albumId,
    required this.artistId,
    required this.duration,
    required this.artistName,
    required this.playlistadddate,
    required this.position,
    required this.licenseCcurl,
    required this.albumImage,
    required this.image,
    required this.audio,
    required this.audiodownload,
    required this.audiodownloadAllowed,
  });

  factory PlaylistTrack.fromJson(Map<String, dynamic> json) =>
      _$PlaylistTrackFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistTrackToJson(this);
}
