// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist(
      id: json['id'] as String?,
      name: json['name'] as String?,
      creationdate: json['creationdate'] as String?,
      userId: json['user_id'] as String?,
      userName: json['user_name'] as String?,
      zip: json['zip'] as String?,
      shorturl: json['shorturl'] as String?,
      shareurl: json['shareurl'] as String?,
      tracks: (json['tracks'] as List<dynamic>?)
          ?.map((e) => PlaylistTrack.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'creationdate': instance.creationdate,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'zip': instance.zip,
      'shorturl': instance.shorturl,
      'shareurl': instance.shareurl,
      'tracks': instance.tracks,
    };
