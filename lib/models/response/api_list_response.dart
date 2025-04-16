import 'package:json_annotation/json_annotation.dart';
import 'package:wathef/models/response/api_header.dart';

part 'api_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiListResponse<T> {
  final ApiHeader header;
  final List<T> results;

  ApiListResponse({
    required this.header,
    required this.results,
  });

  factory ApiListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiListResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object Function(T value) toJsonT,
  ) =>
      _$ApiListResponseToJson(this, toJsonT);
}
