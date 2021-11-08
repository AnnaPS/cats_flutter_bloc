import 'package:catsapp/repository/model/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'breed.dart';

part 'cat.g.dart';

@JsonSerializable()
class Cat extends Equatable {
  const Cat({
    this.breeds,
    this.id,
    this.url,
    this.width,
    this.height,
  });

  final List<Breed>? breeds;
  final String? id;
  final String? url;
  final int? width;
  final int? height;

  factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);

  @override
  List<Object?> get props => [breeds, id, url, width, height];

  static const empty = Cat(
      breeds: [Breed(weight: Weight())], id: '', url: '', width: 0, height: 0);
}
