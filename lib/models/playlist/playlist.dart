import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playlist.g.dart';

@JsonSerializable()
class Playlist extends Equatable {
  final String? id;
  final Title? title;
  final String? link;
  final String? position;
  final List<String>? lang;
  @JsonKey(name: 'date_start')
  final String? dateStart;
  @JsonKey(name: 'date_end')
  final String? dateEnd;
  final TextContent? text;
  final String? type;
  final String? joinid;
  final List<String>? subtitle;
  final String? target;
  final Images? images;

  const Playlist({
    this.id,
    this.title,
    this.link,
    this.position,
    this.lang,
    this.dateStart,
    this.dateEnd,
    this.text,
    this.type,
    this.joinid,
    this.subtitle,
    this.target,
    this.images,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistToJson(this);

  @override
  List<Object?> get props => [
    id,
    title,
    link,
    position,
    lang,
    dateStart,
    dateEnd,
    text,
    type,
    joinid,
    subtitle,
    target,
    images,
  ];
}

@JsonSerializable()
class Title extends Equatable {
  final String? en;
  final String? fr;
  final String? es;
  final String? de;
  final String? pl;
  final String? it;
  final String? ru;
  final String? pt;
  final String? ja;

  const Title({
    this.en,
    this.fr,
    this.es,
    this.de,
    this.pl,
    this.it,
    this.ru,
    this.pt,
    this.ja,
  });

  factory Title.fromJson(Map<String, dynamic> json) => _$TitleFromJson(json);
  Map<String, dynamic> toJson() => _$TitleToJson(this);

  @override
  List<Object?> get props => [en, fr, es, de, pl, it, ru, pt, ja];
}

@JsonSerializable()
class TextContent extends Equatable {
  final String? en;
  final String? fr;
  final String? es;
  final String? de;
  final String? pl;
  final String? it;
  final String? ru;
  final String? pt;
  final String? ja;

  const TextContent({
    this.en,
    this.fr,
    this.es,
    this.de,
    this.pl,
    this.it,
    this.ru,
    this.pt,
    this.ja,
  });

  factory TextContent.fromJson(Map<String, dynamic> json) =>
      _$TextContentFromJson(json);
  Map<String, dynamic> toJson() => _$TextContentToJson(this);

  @override
  List<Object?> get props => [en, fr, es, de, pl, it, ru, pt, ja];
}

@JsonSerializable()
class Images extends Equatable {
  @JsonKey(name: 'size996_350')
  final String? size996x350;
  @JsonKey(name: 'size315_111')
  final String? size315x111;
  @JsonKey(name: 'size600_211')
  final String? size600x211;
  @JsonKey(name: 'size470_165')
  final String? size470x165;

  const Images({
    this.size996x350,
    this.size315x111,
    this.size600x211,
    this.size470x165,
  });

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ImagesToJson(this);

  @override
  List<Object?> get props => [size996x350, size315x111, size600x211, size470x165];
}
