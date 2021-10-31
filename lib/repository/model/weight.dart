import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weight.g.dart';

@JsonSerializable()
class Weight extends Equatable {
  const Weight({
    this.imperial,
    this.metric,
  });

  final String? imperial;
  final String? metric;

  factory Weight.fromJson(Map<String, dynamic> json) => _$WeightFromJson(json);

  @override
  List<Object?> get props => [imperial, metric];
}
