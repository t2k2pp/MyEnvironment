import 'package:flutter_test/flutter_test.dart';
import 'package:health_management/features/health_data/domain/entities/weight_record.dart';

void main() {
  group('WeightRecord', () {
    test('should create WeightRecord with required fields', () {
      final record = WeightRecord(
        id: 'test-id-1',
        date: DateTime(2026, 2, 4),
        weight: 65.5,
      );

      expect(record.id, 'test-id-1');
      expect(record.date, DateTime(2026, 2, 4));
      expect(record.weight, 65.5);
      expect(record.createdAt, isNull);
    });

    test('should serialize to JSON', () {
      final record = WeightRecord(
        id: 'test-id-2',
        date: DateTime(2026, 2, 4),
        weight: 70.0,
      );

      final json = record.toJson();

      expect(json['id'], 'test-id-2');
      expect(json['weight'], 70.0);
    });

    test('should deserialize from JSON', () {
      final json = {
        'id': 'test-id-3',
        'date': '2026-02-04T00:00:00.000',
        'weight': 68.5,
      };

      final record = WeightRecord.fromJson(json);

      expect(record.id, 'test-id-3');
      expect(record.weight, 68.5);
    });

    test('should support copyWith', () {
      final record = WeightRecord(
        id: 'test-id-4',
        date: DateTime(2026, 2, 4),
        weight: 72.0,
      );

      final updated = record.copyWith(weight: 71.5);

      expect(updated.weight, 71.5);
      expect(updated.id, 'test-id-4');
    });
  });
}
