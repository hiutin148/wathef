// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiHeader _$ApiHeaderFromJson(Map<String, dynamic> json) => ApiHeader(
      status: json['status'] as String,
      code: (json['code'] as num).toInt(),
      errorMessage: json['error_message'] as String,
      warnings: json['warnings'] as String,
      resultsCount: (json['results_count'] as num).toInt(),
    );

Map<String, dynamic> _$ApiHeaderToJson(ApiHeader instance) => <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'error_message': instance.errorMessage,
      'warnings': instance.warnings,
      'results_count': instance.resultsCount,
    };
