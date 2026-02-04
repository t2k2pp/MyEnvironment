// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temperature_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TemperatureRecordImpl _$$TemperatureRecordImplFromJson(
  Map<String, dynamic> json,
) => _$TemperatureRecordImpl(
  id: json['id'] as String,
  date: DateTime.parse(json['date'] as String),
  temperature: (json['temperature'] as num).toDouble(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$TemperatureRecordImplToJson(
  _$TemperatureRecordImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date.toIso8601String(),
  'temperature': instance.temperature,
  'createdAt': instance.createdAt?.toIso8601String(),
};
