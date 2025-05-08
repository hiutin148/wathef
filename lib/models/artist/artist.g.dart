// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist(
      id: json['id'] as String,
      title: Title.fromJson(json['title'] as Map<String, dynamic>),
      link: json['link'] as String,
      position: json['position'] as String,
      lang: (json['lang'] as List<dynamic>).map((e) => e as String).toList(),
      dateStart: json['date_start'] as String,
      dateEnd: json['date_end'] as String,
      text: ArtistText.fromJson(json['text'] as Map<String, dynamic>),
      type: json['type'] as String,
      joinid: json['joinid'] as String,
      subtitle: json['subtitle'] as List<dynamic>,
      target: json['target'] as String,
      images: ArtistImages.fromJson(json['images'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title.toJson(),
      'link': instance.link,
      'position': instance.position,
      'lang': instance.lang,
      'date_start': instance.dateStart,
      'date_end': instance.dateEnd,
      'text': instance.text.toJson(),
      'type': instance.type,
      'joinid': instance.joinid,
      'subtitle': instance.subtitle,
      'target': instance.target,
      'images': instance.images.toJson(),
    };

Title _$TitleFromJson(Map<String, dynamic> json) => Title(
      en: json['en'] as String,
      fr: json['fr'] as String,
      es: json['es'] as String,
      de: json['de'] as String,
      pl: json['pl'] as String,
      it: json['it'] as String,
      ru: json['ru'] as String,
      pt: json['pt'] as String,
      ja: json['ja'] as String,
    );

Map<String, dynamic> _$TitleToJson(Title instance) => <String, dynamic>{
      'en': instance.en,
      'fr': instance.fr,
      'es': instance.es,
      'de': instance.de,
      'pl': instance.pl,
      'it': instance.it,
      'ru': instance.ru,
      'pt': instance.pt,
      'ja': instance.ja,
    };

ArtistText _$ArtistTextFromJson(Map<String, dynamic> json) => ArtistText(
      en: json['en'] as String,
      fr: json['fr'] as String,
      es: json['es'] as String,
      de: json['de'] as String,
      pl: json['pl'] as String,
      it: json['it'] as String,
      ru: json['ru'] as String,
      pt: json['pt'] as String,
      ja: json['ja'] as String,
    );

Map<String, dynamic> _$ArtistTextToJson(ArtistText instance) =>
    <String, dynamic>{
      'en': instance.en,
      'fr': instance.fr,
      'es': instance.es,
      'de': instance.de,
      'pl': instance.pl,
      'it': instance.it,
      'ru': instance.ru,
      'pt': instance.pt,
      'ja': instance.ja,
    };

ArtistImages _$ArtistImagesFromJson(Map<String, dynamic> json) => ArtistImages(
      size996_350: json['size996_350'] as String,
      size315_111: json['size315_111'] as String,
      size600_211: json['size600_211'] as String,
      size470_165: json['size470_165'] as String,
    );

Map<String, dynamic> _$ArtistImagesToJson(ArtistImages instance) =>
    <String, dynamic>{
      'size996_350': instance.size996_350,
      'size315_111': instance.size315_111,
      'size600_211': instance.size600_211,
      'size470_165': instance.size470_165,
    };
