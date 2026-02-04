import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_goal.freezed.dart';
part 'health_goal.g.dart';

/// 目標タイプ
enum GoalType {
  steps,      // 歩数
  weight,     // 体重
  exercise,   // 運動時間
}

/// 健康目標エンティティ
@freezed
class HealthGoal with _$HealthGoal {
  const factory HealthGoal({
    required String id,
    required GoalType type,
    required double targetValue,
    required DateTime startDate,
    DateTime? endDate,
    DateTime? createdAt,
  }) = _HealthGoal;

  factory HealthGoal.fromJson(Map<String, dynamic> json) =>
      _$HealthGoalFromJson(json);
}
