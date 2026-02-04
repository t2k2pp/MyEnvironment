import 'package:freezed_annotation/freezed_annotation.dart';

part 'temperature_record.freezed.dart';
part 'temperature_record.g.dart';

/// 体温記録エンティティ
@freezed
class TemperatureRecord with _$TemperatureRecord {
  const factory TemperatureRecord({
    required String id,
    required DateTime date,
    required double temperature, // ℃
    DateTime? createdAt,
  }) = _TemperatureRecord;

  factory TemperatureRecord.fromJson(Map<String, dynamic> json) =>
      _$TemperatureRecordFromJson(json);
}
