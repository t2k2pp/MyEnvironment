import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_record.freezed.dart';
part 'exercise_record.g.dart';

/// 運動記録エンティティ
@freezed
class ExerciseRecord with _$ExerciseRecord {
  const factory ExerciseRecord({
    required String id,
    required DateTime date,
    required String exerciseType, // ウォーキング、ランニング等
    required int durationMinutes,
    String? note,
    DateTime? createdAt,
  }) = _ExerciseRecord;

  factory ExerciseRecord.fromJson(Map<String, dynamic> json) =>
      _$ExerciseRecordFromJson(json);
}
