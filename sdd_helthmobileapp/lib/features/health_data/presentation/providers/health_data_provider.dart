import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/database/health_database.dart';
import '../../data/datasources/health_local_datasource.dart';
import '../../data/datasources/health_connect_datasource.dart';
import '../../data/repositories/health_data_repository.dart';
import '../../domain/entities/step_record.dart';
import '../../domain/entities/weight_record.dart';
import '../../domain/entities/temperature_record.dart';
import '../../domain/entities/exercise_record.dart';

part 'health_data_provider.g.dart';

/// データベースプロバイダー
@Riverpod(keepAlive: true)
HealthDatabase healthDatabase(HealthDatabaseRef ref) {
  return HealthDatabase();
}

/// ローカルデータソースプロバイダー
@riverpod
HealthLocalDatasource healthLocalDatasource(HealthLocalDatasourceRef ref) {
  final db = ref.watch(healthDatabaseProvider);
  return HealthLocalDatasource(db);
}

/// Health Connectデータソースプロバイダー
@riverpod
HealthConnectDatasource healthConnectDatasource(HealthConnectDatasourceRef ref) {
  return HealthConnectDatasource();
}

/// Repositoryプロバイダー
@riverpod
HealthDataRepository healthDataRepository(HealthDataRepositoryRef ref) {
  return HealthDataRepository(
    localDatasource: ref.watch(healthLocalDatasourceProvider),
    healthConnectDatasource: ref.watch(healthConnectDatasourceProvider),
  );
}

/// 今日の歩数
@riverpod
Future<int> todaySteps(TodayStepsRef ref) async {
  final repository = ref.watch(healthDataRepositoryProvider);
  return await repository.getTodaySteps();
}

/// 歩数記録リスト
@riverpod
Stream<List<StepRecord>> stepRecords(StepRecordsRef ref) {
  final repository = ref.watch(healthDataRepositoryProvider);
  return repository.watchStepRecords();
}

/// 体重記録リスト
@riverpod
Stream<List<WeightRecord>> weightRecords(WeightRecordsRef ref) {
  final repository = ref.watch(healthDataRepositoryProvider);
  return repository.watchWeightRecords();
}

/// 体温記録リスト
@riverpod
Stream<List<TemperatureRecord>> temperatureRecords(TemperatureRecordsRef ref) {
  final repository = ref.watch(healthDataRepositoryProvider);
  return repository.watchTemperatureRecords();
}

/// 運動記録リスト
@riverpod
Stream<List<ExerciseRecord>> exerciseRecords(ExerciseRecordsRef ref) {
  final repository = ref.watch(healthDataRepositoryProvider);
  return repository.watchExerciseRecords();
}

/// Health Connect連携状態
@riverpod
class HealthConnectStatus extends _$HealthConnectStatus {
  @override
  FutureOr<bool> build() async {
    final repository = ref.watch(healthDataRepositoryProvider);
    return await repository.isHealthConnectAvailable();
  }

  Future<bool> requestPermissions() async {
    state = const AsyncValue.loading();
    final repository = ref.read(healthDataRepositoryProvider);
    final result = await repository.requestHealthPermissions();
    state = AsyncValue.data(result);
    return result;
  }
}
