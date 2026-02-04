import 'package:freezed_annotation/freezed_annotation.dart';

part 'step_record.freezed.dart';
part 'step_record.g.dart';

/// 歩数記録エンティティ
@freezed
class StepRecord with _$StepRecord {
  const factory StepRecord({
    required String id,
    required DateTime date,
    required int steps,
    @Default(false) bool isAutoSync,
    DateTime? createdAt,
  }) = _StepRecord;

  factory StepRecord.fromJson(Map<String, dynamic> json) =>
      _$StepRecordFromJson(json);
}
