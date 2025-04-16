import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'track.g.dart';

@JsonSerializable()
class Track {
  final String id;
  final String name;
  final int duration;

  @JsonKey(name: 'artist_id')
  final String artistId;

  @JsonKey(name: 'artist_name')
  final String artistName;

  @JsonKey(name: 'artist_idstr')
  final String artistIdStr;

  @JsonKey(name: 'album_name')
  final String albumName;

  @JsonKey(name: 'album_id')
  final String albumId;

  @JsonKey(name: 'license_ccurl')
  final String licenseCcurl;

  final int position;

  @JsonKey(name: 'releasedate')
  final String releaseDate;

  @JsonKey(name: 'album_image')
  final String albumImage;

  final String audio;

  final String audiodownload;

  final String prourl;
  final String shorturl;
  final String shareurl;

  /// `waveform` là JSON string nên cần custom getter/setter
  @JsonKey(fromJson: _waveformFromJson, toJson: _waveformToJson)
  final List<int> waveform;

  Track({
    required this.id,
    required this.name,
    required this.duration,
    required this.artistId,
    required this.artistName,
    required this.artistIdStr,
    required this.albumName,
    required this.albumId,
    required this.licenseCcurl,
    required this.position,
    required this.releaseDate,
    required this.albumImage,
    required this.audio,
    required this.audiodownload,
    required this.prourl,
    required this.shorturl,
    required this.shareurl,
    required this.waveform,
  });

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);

  /// Custom methods for `waveform` parsing
  static List<int> _waveformFromJson(String jsonString) {
    final decoded = jsonDecode(jsonString);
    return List<int>.from(decoded['peaks']);
  }

  static String _waveformToJson(List<int> waveform) {
    return jsonEncode({'peaks': waveform});
  }
}
