import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

@JsonSerializable(explicitToJson: true)
class Artist {
  final String id;
  final Title title;
  final String link;
  final String position;
  final List<String> lang;

  @JsonKey(name: 'date_start')
  final String dateStart;

  @JsonKey(name: 'date_end')
  final String dateEnd;

  final ArtistText text;
  final String type;
  final String joinid;
  final List<dynamic> subtitle;
  final String target;
  final ArtistImages images;

  Artist({
    required this.id,
    required this.title,
    required this.link,
    required this.position,
    required this.lang,
    required this.dateStart,
    required this.dateEnd,
    required this.text,
    required this.type,
    required this.joinid,
    required this.subtitle,
    required this.target,
    required this.images,
  });

  factory Artist.fromJson(Map<String, dynamic> json) =>
      _$ArtistFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}

@JsonSerializable()
class Title {
  final String en;
  final String fr;
  final String es;
  final String de;
  final String pl;
  final String it;
  final String ru;
  final String pt;
  final String ja;

  Title({
    required this.en,
    required this.fr,
    required this.es,
    required this.de,
    required this.pl,
    required this.it,
    required this.ru,
    required this.pt,
    required this.ja,
  });

  factory Title.fromJson(Map<String, dynamic> json) =>
      _$TitleFromJson(json);

  Map<String, dynamic> toJson() => _$TitleToJson(this);
}

@JsonSerializable()
class ArtistText {
  final String en;
  final String fr;
  final String es;
  final String de;
  final String pl;
  final String it;
  final String ru;
  final String pt;
  final String ja;

  ArtistText({
    required this.en,
    required this.fr,
    required this.es,
    required this.de,
    required this.pl,
    required this.it,
    required this.ru,
    required this.pt,
    required this.ja,
  });

  factory ArtistText.fromJson(Map<String, dynamic> json) =>
      _$ArtistTextFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistTextToJson(this);
}

@JsonSerializable()
class ArtistImages {
  @JsonKey(name: 'size996_350')
  final String size996_350;

  @JsonKey(name: 'size315_111')
  final String size315_111;

  @JsonKey(name: 'size600_211')
  final String size600_211;

  @JsonKey(name: 'size470_165')
  final String size470_165;

  ArtistImages({
    required this.size996_350,
    required this.size315_111,
    required this.size600_211,
    required this.size470_165,
  });

  factory ArtistImages.fromJson(Map<String, dynamic> json) =>
      _$ArtistImagesFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistImagesToJson(this);
}
