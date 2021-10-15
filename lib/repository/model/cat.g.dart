// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cat _$CatFromJson(Map<String, dynamic> json) {
  return Cat(
    breeds: (json['breeds'] as List<dynamic>?)
        ?.map((e) => Breed.fromJson(e as Map<String, dynamic>))
        .toList(),
    id: json['id'] as String?,
    url: json['url'] as String?,
    width: json['width'] as int?,
    height: json['height'] as int?,
  );
}

Map<String, dynamic> _$CatToJson(Cat instance) => <String, dynamic>{
      'breeds': instance.breeds,
      'id': instance.id,
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };
