import 'package:flutter_test/flutter_test.dart';
import 'package:health_management/features/goals/domain/health_goal.dart';

void main() {
  group('HealthGoal', () {
    test('should create HealthGoal with required fields', () {
      final goal = HealthGoal(
        id: 'test-id-1',
        type: GoalType.steps,
        targetValue: 10000,
        startDate: DateTime(2026, 2, 1),
      );

      expect(goal.id, 'test-id-1');
      expect(goal.type, GoalType.steps);
      expect(goal.targetValue, 10000);
      expect(goal.endDate, isNull);
    });

    test('should create weight goal', () {
      final goal = HealthGoal(
        id: 'test-id-2',
        type: GoalType.weight,
        targetValue: 65.0,
        startDate: DateTime(2026, 2, 1),
        endDate: DateTime(2026, 6, 1),
      );

      expect(goal.type, GoalType.weight);
      expect(goal.targetValue, 65.0);
      expect(goal.endDate, DateTime(2026, 6, 1));
    });

    test('should create exercise goal', () {
      final goal = HealthGoal(
        id: 'test-id-3',
        type: GoalType.exercise,
        targetValue: 30,
        startDate: DateTime(2026, 2, 1),
      );

      expect(goal.type, GoalType.exercise);
      expect(goal.targetValue, 30);
    });

    test('should serialize to JSON', () {
      final goal = HealthGoal(
        id: 'test-id-4',
        type: GoalType.steps,
        targetValue: 8000,
        startDate: DateTime(2026, 2, 1),
      );

      final json = goal.toJson();

      expect(json['id'], 'test-id-4');
      expect(json['type'], 'steps');
      expect(json['targetValue'], 8000);
    });

    test('should deserialize from JSON', () {
      final json = {
        'id': 'test-id-5',
        'type': 'weight',
        'targetValue': 70.0,
        'startDate': '2026-02-01T00:00:00.000',
      };

      final goal = HealthGoal.fromJson(json);

      expect(goal.id, 'test-id-5');
      expect(goal.type, GoalType.weight);
      expect(goal.targetValue, 70.0);
    });
  });

  group('GoalType', () {
    test('should have correct values', () {
      expect(GoalType.values.length, 3);
      expect(GoalType.values.contains(GoalType.steps), true);
      expect(GoalType.values.contains(GoalType.weight), true);
      expect(GoalType.values.contains(GoalType.exercise), true);
    });
  });
}
