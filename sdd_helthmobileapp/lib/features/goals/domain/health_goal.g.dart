// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HealthGoalImpl _$$HealthGoalImplFromJson(Map<String, dynamic> json) =>
    _$HealthGoalImpl(
      id: json['id'] as String,
      type: $enumDecode(_$GoalTypeEnumMap, json['type']),
      targetValue: (json['targetValue'] as num).toDouble(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$HealthGoalImplToJson(_$HealthGoalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$GoalTypeEnumMap[instance.type]!,
      'targetValue': instance.targetValue,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$GoalTypeEnumMap = {
  GoalType.steps: 'steps',
  GoalType.weight: 'weight',
  GoalType.exercise: 'exercise',
};
