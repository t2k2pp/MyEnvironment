import 'package:freezed_annotation/freezed_annotation.dart';

part 'weight_record.freezed.dart';
part 'weight_record.g.dart';

/// 体重記録エンティティ
@freezed
class WeightRecord with _$WeightRecord {
  const factory WeightRecord({
    required String id,
    required DateTime date,
    required double weight, // kg
    DateTime? createdAt,
  }) = _WeightRecord;

  factory WeightRecord.fromJson(Map<String, dynamic> json) =>
      _$WeightRecordFromJson(json);
}
