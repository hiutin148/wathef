// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiListResponse<T> _$ApiListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ApiListResponse<T>(
      headers: ApiHeader.fromJson(json['headers'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$ApiListResponseToJson<T>(
  ApiListResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'headers': instance.headers,
      'results': instance.results.map(toJsonT).toList(),
    };
