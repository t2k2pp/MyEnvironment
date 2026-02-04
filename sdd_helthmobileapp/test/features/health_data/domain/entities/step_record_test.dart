import 'package:flutter_test/flutter_test.dart';
import 'package:health_management/features/health_data/domain/entities/step_record.dart';

void main() {
  group('StepRecord', () {
    test('should create StepRecord with required fields', () {
      final record = StepRecord(
        id: 'test-id-1',
        date: DateTime(2026, 2, 4),
        steps: 5000,
      );

      expect(record.id, 'test-id-1');
      expect(record.date, DateTime(2026, 2, 4));
      expect(record.steps, 5000);
      expect(record.isAutoSync, false); // default value
      expect(record.createdAt, isNull);
    });

    test('should create StepRecord with optional fields', () {
      final now = DateTime.now();
      final record = StepRecord(
        id: 'test-id-2',
        date: DateTime(2026, 2, 4),
        steps: 10000,
        isAutoSync: true,
        createdAt: now,
      );

      expect(record.isAutoSync, true);
      expect(record.createdAt, now);
    });

    test('should serialize to JSON', () {
      final record = StepRecord(
        id: 'test-id-3',
        date: DateTime(2026, 2, 4),
        steps: 7500,
        isAutoSync: true,
      );

      final json = record.toJson();

      expect(json['id'], 'test-id-3');
      expect(json['steps'], 7500);
      expect(json['isAutoSync'], true);
    });

    test('should deserialize from JSON', () {
      final json = {
        'id': 'test-id-4',
        'date': '2026-02-04T00:00:00.000',
        'steps': 8000,
        'isAutoSync': false,
      };

      final record = StepRecord.fromJson(json);

      expect(record.id, 'test-id-4');
      expect(record.steps, 8000);
      expect(record.isAutoSync, false);
    });

    test('should support copyWith', () {
      final record = StepRecord(
        id: 'test-id-5',
        date: DateTime(2026, 2, 4),
        steps: 3000,
      );

      final updated = record.copyWith(steps: 5000);

      expect(updated.id, 'test-id-5');
      expect(updated.steps, 5000);
    });

    test('should be equal when same values', () {
      final record1 = StepRecord(
        id: 'test-id-6',
        date: DateTime(2026, 2, 4),
        steps: 4000,
      );
      final record2 = StepRecord(
        id: 'test-id-6',
        date: DateTime(2026, 2, 4),
        steps: 4000,
      );

      expect(record1, equals(record2));
    });
  });
}
