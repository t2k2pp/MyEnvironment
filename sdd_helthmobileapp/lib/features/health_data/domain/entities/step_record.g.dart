// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StepRecordImpl _$$StepRecordImplFromJson(Map<String, dynamic> json) =>
    _$StepRecordImpl(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      steps: (json['steps'] as num).toInt(),
      isAutoSync: json['isAutoSync'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$StepRecordImplToJson(_$StepRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'steps': instance.steps,
      'isAutoSync': instance.isAutoSync,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
