// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weight _$WeightFromJson(Map<String, dynamic> json) {
  return Weight(
    imperial: json['imperial'] as String?,
    metric: json['metric'] as String?,
  );
}

Map<String, dynamic> _$WeightToJson(Weight instance) => <String, dynamic>{
      'imperial': instance.imperial,
      'metric': instance.metric,
    };
