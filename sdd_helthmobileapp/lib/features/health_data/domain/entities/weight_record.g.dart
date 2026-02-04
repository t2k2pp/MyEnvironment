// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeightRecordImpl _$$WeightRecordImplFromJson(Map<String, dynamic> json) =>
    _$WeightRecordImpl(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      weight: (json['weight'] as num).toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$WeightRecordImplToJson(_$WeightRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'weight': instance.weight,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
