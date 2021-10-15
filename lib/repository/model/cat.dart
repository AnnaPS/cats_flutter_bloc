import 'package:json_annotation/json_annotation.dart';

import 'breed.dart';

part 'cat.g.dart';

@JsonSerializable()
class Cat {
  Cat({
    this.breeds,
    this.id,
    this.url,
    this.width,
    this.height,
  });

  List<Breed>? breeds;
  String? id;
  String? url;
  int? width;
  int? height;

  Cat copyWith({
    List<Breed>? breeds,
    String? id,
    String? url,
    int? width,
    int? height,
  }) {
    return Cat(
      breeds: breeds ?? this.breeds,
      id: id ?? this.id,
      url: url ?? this.url,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);
  Map<String, dynamic> toJson() => _$CatToJson(this);
}
