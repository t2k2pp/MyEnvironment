import 'package:flutter_test/flutter_test.dart';
import 'package:health_management/features/health_data/domain/entities/temperature_record.dart';

void main() {
  group('TemperatureRecord', () {
    test('should create TemperatureRecord with required fields', () {
      final record = TemperatureRecord(
        id: 'test-id-1',
        date: DateTime(2026, 2, 4),
        temperature: 36.5,
      );

      expect(record.id, 'test-id-1');
      expect(record.date, DateTime(2026, 2, 4));
      expect(record.temperature, 36.5);
    });

    test('should validate normal temperature range', () {
      final record = TemperatureRecord(
        id: 'test-id-2',
        date: DateTime(2026, 2, 4),
        temperature: 36.8,
      );

      expect(record.temperature, greaterThanOrEqualTo(35.0));
      expect(record.temperature, lessThanOrEqualTo(42.0));
    });

    test('should serialize to JSON', () {
      final record = TemperatureRecord(
        id: 'test-id-3',
        date: DateTime(2026, 2, 4),
        temperature: 37.2,
      );

      final json = record.toJson();

      expect(json['id'], 'test-id-3');
      expect(json['temperature'], 37.2);
    });

    test('should deserialize from JSON', () {
      final json = {
        'id': 'test-id-4',
        'date': '2026-02-04T00:00:00.000',
        'temperature': 36.0,
      };

      final record = TemperatureRecord.fromJson(json);

      expect(record.id, 'test-id-4');
      expect(record.temperature, 36.0);
    });
  });
}
