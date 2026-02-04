import 'package:flutter_test/flutter_test.dart';
import 'package:health_management/features/health_data/domain/entities/exercise_record.dart';

void main() {
  group('ExerciseRecord', () {
    test('should create ExerciseRecord with required fields', () {
      final record = ExerciseRecord(
        id: 'test-id-1',
        date: DateTime(2026, 2, 4),
        exerciseType: 'ウォーキング',
        durationMinutes: 30,
      );

      expect(record.id, 'test-id-1');
      expect(record.exerciseType, 'ウォーキング');
      expect(record.durationMinutes, 30);
      expect(record.note, isNull);
    });

    test('should create ExerciseRecord with optional note', () {
      final record = ExerciseRecord(
        id: 'test-id-2',
        date: DateTime(2026, 2, 4),
        exerciseType: 'ランニング',
        durationMinutes: 45,
        note: '5km走った',
      );

      expect(record.note, '5km走った');
    });

    test('should serialize to JSON', () {
      final record = ExerciseRecord(
        id: 'test-id-3',
        date: DateTime(2026, 2, 4),
        exerciseType: '筋トレ',
        durationMinutes: 60,
        note: '腕立て50回',
      );

      final json = record.toJson();

      expect(json['id'], 'test-id-3');
      expect(json['exerciseType'], '筋トレ');
      expect(json['durationMinutes'], 60);
      expect(json['note'], '腕立て50回');
    });

    test('should deserialize from JSON', () {
      final json = {
        'id': 'test-id-4',
        'date': '2026-02-04T00:00:00.000',
        'exerciseType': 'ヨガ',
        'durationMinutes': 40,
      };

      final record = ExerciseRecord.fromJson(json);

      expect(record.id, 'test-id-4');
      expect(record.exerciseType, 'ヨガ');
      expect(record.durationMinutes, 40);
    });

    test('should support copyWith', () {
      final record = ExerciseRecord(
        id: 'test-id-5',
        date: DateTime(2026, 2, 4),
        exerciseType: 'サイクリング',
        durationMinutes: 90,
      );

      final updated = record.copyWith(durationMinutes: 120);

      expect(updated.durationMinutes, 120);
      expect(updated.exerciseType, 'サイクリング');
    });
  });
}
