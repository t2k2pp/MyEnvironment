import '../datasources/health_local_datasource.dart';
import '../datasources/health_connect_datasource.dart';
import '../../domain/entities/step_record.dart';
import '../../domain/entities/weight_record.dart';
import '../../domain/entities/temperature_record.dart';
import '../../domain/entities/exercise_record.dart';

/// 健康データのリポジトリ
/// ローカルDBとHealth Connectの両方からデータを取得・保存
class HealthDataRepository {
  final HealthLocalDatasource _localDatasource;
  final HealthConnectDatasource _healthConnectDatasource;

  HealthDataRepository({
    required HealthLocalDatasource localDatasource,
    required HealthConnectDatasource healthConnectDatasource,
  })  : _localDatasource = localDatasource,
        _healthConnectDatasource = healthConnectDatasource;

  // ========== 歩数 ==========

  /// 今日の歩数を取得（Health Connectから）
  Future<int> getTodaySteps() async {
    return await _healthConnectDatasource.getTodaySteps();
  }

  /// 保存された歩数記録を取得
  Future<List<StepRecord>> getStepRecords({DateTime? start, DateTime? end}) async {
    if (start != null && end != null) {
      return await _localDatasource.getStepRecordsByDateRange(start, end);
    }
    return await _localDatasource.getAllStepRecords();
  }

  /// 歩数記録を監視
  Stream<List<StepRecord>> watchStepRecords() {
    return _localDatasource.watchStepRecords();
  }

  /// 歩数を保存
  Future<void> saveStepRecord(StepRecord record) async {
    await _localDatasource.saveStepRecord(record);
  }

  /// 歩数を削除
  Future<void> deleteStepRecord(String id) async {
    await _localDatasource.deleteStepRecord(id);
  }

  /// Health Connectの権限をリクエスト
  Future<bool> requestHealthPermissions() async {
    return await _healthConnectDatasource.requestPermissions();
  }

  /// Health Connectが利用可能かチェック
  Future<bool> isHealthConnectAvailable() async {
    return await _healthConnectDatasource.isHealthConnectAvailable();
  }

  // ========== 体重 ==========

  Future<List<WeightRecord>> getWeightRecords({DateTime? start, DateTime? end}) async {
    if (start != null && end != null) {
      return await _localDatasource.getWeightRecordsByDateRange(start, end);
    }
    return await _localDatasource.getAllWeightRecords();
  }

  Stream<List<WeightRecord>> watchWeightRecords() {
    return _localDatasource.watchWeightRecords();
  }

  Future<void> saveWeightRecord(WeightRecord record) async {
    await _localDatasource.saveWeightRecord(record);
  }

  Future<void> deleteWeightRecord(String id) async {
    await _localDatasource.deleteWeightRecord(id);
  }

  // ========== 体温 ==========

  Future<List<TemperatureRecord>> getTemperatureRecords({DateTime? start, DateTime? end}) async {
    if (start != null && end != null) {
      return await _localDatasource.getTemperatureRecordsByDateRange(start, end);
    }
    return await _localDatasource.getAllTemperatureRecords();
  }

  Stream<List<TemperatureRecord>> watchTemperatureRecords() {
    return _localDatasource.watchTemperatureRecords();
  }

  Future<void> saveTemperatureRecord(TemperatureRecord record) async {
    await _localDatasource.saveTemperatureRecord(record);
  }

  Future<void> deleteTemperatureRecord(String id) async {
    await _localDatasource.deleteTemperatureRecord(id);
  }

  // ========== 運動 ==========

  Future<List<ExerciseRecord>> getExerciseRecords({DateTime? start, DateTime? end}) async {
    if (start != null && end != null) {
      return await _localDatasource.getExerciseRecordsByDateRange(start, end);
    }
    return await _localDatasource.getAllExerciseRecords();
  }

  Stream<List<ExerciseRecord>> watchExerciseRecords() {
    return _localDatasource.watchExerciseRecords();
  }

  Future<void> saveExerciseRecord(ExerciseRecord record) async {
    await _localDatasource.saveExerciseRecord(record);
  }

  Future<void> deleteExerciseRecord(String id) async {
    await _localDatasource.deleteExerciseRecord(id);
  }
}
