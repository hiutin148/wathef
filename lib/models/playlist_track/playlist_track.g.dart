// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistTrack _$PlaylistTrackFromJson(Map<String, dynamic> json) =>
    PlaylistTrack(
      id: json['id'] as String,
      name: json['name'] as String,
      albumId: json['album_id'] as String,
      artistId: json['artist_id'] as String,
      duration: json['duration'] as String,
      artistName: json['artist_name'] as String,
      playlistadddate: json['playlistadddate'] as String,
      position: json['position'] as String,
      licenseCcurl: json['license_ccurl'] as String,
      albumImage: json['album_image'] as String,
      image: json['image'] as String,
      audio: json['audio'] as String,
      audiodownload: json['audiodownload'] as String,
      audiodownloadAllowed: json['audiodownload_allowed'] as bool,
    );

Map<String, dynamic> _$PlaylistTrackToJson(PlaylistTrack instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'album_id': instance.albumId,
      'artist_id': instance.artistId,
      'duration': instance.duration,
      'artist_name': instance.artistName,
      'playlistadddate': instance.playlistadddate,
      'position': instance.position,
      'license_ccurl': instance.licenseCcurl,
      'album_image': instance.albumImage,
      'image': instance.image,
      'audio': instance.audio,
      'audiodownload': instance.audiodownload,
      'audiodownload_allowed': instance.audiodownloadAllowed,
    };
