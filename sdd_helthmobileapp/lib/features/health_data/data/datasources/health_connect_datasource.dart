import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

/// Health Connect APIからのデータ取得を担当
class HealthConnectDatasource {
  final Health _health = Health();

  /// Health Connectの権限をリクエスト
  Future<bool> requestPermissions() async {
    // Activity Recognition権限
    final activityStatus = await Permission.activityRecognition.request();
    if (!activityStatus.isGranted) {
      return false;
    }

    // Health Connect権限
    final types = [
      HealthDataType.STEPS,
      HealthDataType.TOTAL_CALORIES_BURNED,
      HealthDataType.DISTANCE_DELTA,
    ];

    final permissions = types.map((e) => HealthDataAccess.READ).toList();
    
    final hasPermissions = await _health.hasPermissions(types, permissions: permissions);
    if (hasPermissions == true) {
      return true;
    }

    final granted = await _health.requestAuthorization(types, permissions: permissions);
    return granted;
  }

  /// 今日の歩数を取得
  Future<int> getTodaySteps() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    
    final steps = await _health.getTotalStepsInInterval(midnight, now);
    return steps ?? 0;
  }

  /// 指定日の歩数を取得
  Future<int> getStepsForDate(DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    
    final steps = await _health.getTotalStepsInInterval(start, end);
    return steps ?? 0;
  }

  /// 期間内の歩数データを取得
  Future<List<HealthDataPoint>> getStepsInRange(DateTime start, DateTime end) async {
    final types = [HealthDataType.STEPS];
    
    final dataPoints = await _health.getHealthDataFromTypes(
      types: types,
      startTime: start,
      endTime: end,
    );
    
    return dataPoints;
  }

  /// Health Connectが利用可能かチェック
  Future<bool> isHealthConnectAvailable() async {
    try {
      final status = await _health.getHealthConnectSdkStatus();
      return status == HealthConnectSdkStatus.sdkAvailable;
    } catch (e) {
      return false;
    }
  }
}
