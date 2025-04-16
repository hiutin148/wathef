import 'package:json_annotation/json_annotation.dart';

part 'api_header.g.dart';

@JsonSerializable()
class ApiHeader {
  final String status;
  final int code;
  @JsonKey(name: 'error_message')
  final String errorMessage;
  final String warnings;
  @JsonKey(name: 'results_count')
  final int resultsCount;

  const ApiHeader({
    required this.status,
    required this.code,
    required this.errorMessage,
    required this.warnings,
    required this.resultsCount,
  });

  factory ApiHeader.fromJson(Map<String, dynamic> json) =>
      _$ApiHeaderFromJson(json);
}
