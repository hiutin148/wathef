// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedPlaylist _$FeedPlaylistFromJson(Map<String, dynamic> json) => FeedPlaylist(
      id: json['id'] as String?,
      title: json['title'] == null
          ? null
          : Title.fromJson(json['title'] as Map<String, dynamic>),
      link: json['link'] as String?,
      position: json['position'] as String?,
      lang: (json['lang'] as List<dynamic>?)?.map((e) => e as String).toList(),
      dateStart: json['date_start'] as String?,
      dateEnd: json['date_end'] as String?,
      text: json['text'] == null
          ? null
          : TextContent.fromJson(json['text'] as Map<String, dynamic>),
      type: json['type'] as String?,
      joinid: json['joinid'] as String?,
      subtitle: (json['subtitle'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      target: json['target'] as String?,
      images: json['images'] == null
          ? null
          : Images.fromJson(json['images'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedPlaylistToJson(FeedPlaylist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'link': instance.link,
      'position': instance.position,
      'lang': instance.lang,
      'date_start': instance.dateStart,
      'date_end': instance.dateEnd,
      'text': instance.text,
      'type': instance.type,
      'joinid': instance.joinid,
      'subtitle': instance.subtitle,
      'target': instance.target,
      'images': instance.images,
    };

Title _$TitleFromJson(Map<String, dynamic> json) => Title(
      en: json['en'] as String?,
      fr: json['fr'] as String?,
      es: json['es'] as String?,
      de: json['de'] as String?,
      pl: json['pl'] as String?,
      it: json['it'] as String?,
      ru: json['ru'] as String?,
      pt: json['pt'] as String?,
      ja: json['ja'] as String?,
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

TextContent _$TextContentFromJson(Map<String, dynamic> json) => TextContent(
      en: json['en'] as String?,
      fr: json['fr'] as String?,
      es: json['es'] as String?,
      de: json['de'] as String?,
      pl: json['pl'] as String?,
      it: json['it'] as String?,
      ru: json['ru'] as String?,
      pt: json['pt'] as String?,
      ja: json['ja'] as String?,
    );

Map<String, dynamic> _$TextContentToJson(TextContent instance) =>
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

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      size996x350: json['size996_350'] as String?,
      size315x111: json['size315_111'] as String?,
      size600x211: json['size600_211'] as String?,
      size470x165: json['size470_165'] as String?,
    );

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'size996_350': instance.size996x350,
      'size315_111': instance.size315x111,
      'size600_211': instance.size600x211,
      'size470_165': instance.size470x165,
    };
