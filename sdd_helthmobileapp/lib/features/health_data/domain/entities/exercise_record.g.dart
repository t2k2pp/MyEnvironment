// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExerciseRecordImpl _$$ExerciseRecordImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseRecordImpl(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      exerciseType: json['exerciseType'] as String,
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      note: json['note'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ExerciseRecordImplToJson(
  _$ExerciseRecordImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date.toIso8601String(),
  'exerciseType': instance.exerciseType,
  'durationMinutes': instance.durationMinutes,
  'note': instance.note,
  'createdAt': instance.createdAt?.toIso8601String(),
};
