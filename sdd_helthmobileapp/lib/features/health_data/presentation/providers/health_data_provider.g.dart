// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$healthDatabaseHash() => r'4a7a0288908f5d34fdfc7034263e68ec19693ef3';

/// データベースプロバイダー
///
/// Copied from [healthDatabase].
@ProviderFor(healthDatabase)
final healthDatabaseProvider = Provider<HealthDatabase>.internal(
  healthDatabase,
  name: r'healthDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$healthDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HealthDatabaseRef = ProviderRef<HealthDatabase>;
String _$healthLocalDatasourceHash() =>
    r'aa5b9c5787429c2d34e82876b7f5ac791e2d8028';

/// ローカルデータソースプロバイダー
///
/// Copied from [healthLocalDatasource].
@ProviderFor(healthLocalDatasource)
final healthLocalDatasourceProvider =
    AutoDisposeProvider<HealthLocalDatasource>.internal(
      healthLocalDatasource,
      name: r'healthLocalDatasourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$healthLocalDatasourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HealthLocalDatasourceRef =
    AutoDisposeProviderRef<HealthLocalDatasource>;
String _$healthConnectDatasourceHash() =>
    r'1c72dbcd15059ea8aaa3b24dce0192a757c040cf';

/// Health Connectデータソースプロバイダー
///
/// Copied from [healthConnectDatasource].
@ProviderFor(healthConnectDatasource)
final healthConnectDatasourceProvider =
    AutoDisposeProvider<HealthConnectDatasource>.internal(
      healthConnectDatasource,
      name: r'healthConnectDatasourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$healthConnectDatasourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HealthConnectDatasourceRef =
    AutoDisposeProviderRef<HealthConnectDatasource>;
String _$healthDataRepositoryHash() =>
    r'e19a01dd6a8856c32e1400f4670f93454c92c304';

/// Repositoryプロバイダー
///
/// Copied from [healthDataRepository].
@ProviderFor(healthDataRepository)
final healthDataRepositoryProvider =
    AutoDisposeProvider<HealthDataRepository>.internal(
      healthDataRepository,
      name: r'healthDataRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$healthDataRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HealthDataRepositoryRef = AutoDisposeProviderRef<HealthDataRepository>;
String _$todayStepsHash() => r'1fddb783cc39504613c9898a4761053a9d8483f7';

/// 今日の歩数
///
/// Copied from [todaySteps].
@ProviderFor(todaySteps)
final todayStepsProvider = AutoDisposeFutureProvider<int>.internal(
  todaySteps,
  name: r'todayStepsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todayStepsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayStepsRef = AutoDisposeFutureProviderRef<int>;
String _$stepRecordsHash() => r'9d6264179cd67cda713a1dd391ea19f5e8752df4';

/// 歩数記録リスト
///
/// Copied from [stepRecords].
@ProviderFor(stepRecords)
final stepRecordsProvider =
    AutoDisposeStreamProvider<List<StepRecord>>.internal(
      stepRecords,
      name: r'stepRecordsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$stepRecordsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StepRecordsRef = AutoDisposeStreamProviderRef<List<StepRecord>>;
String _$weightRecordsHash() => r'd24dc4d1bb346f44004edf3c8f580e3015bc7d03';

/// 体重記録リスト
///
/// Copied from [weightRecords].
@ProviderFor(weightRecords)
final weightRecordsProvider =
    AutoDisposeStreamProvider<List<WeightRecord>>.internal(
      weightRecords,
      name: r'weightRecordsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$weightRecordsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WeightRecordsRef = AutoDisposeStreamProviderRef<List<WeightRecord>>;
String _$temperatureRecordsHash() =>
    r'b4695a9189287118db98396e7f20a598bb994100';

/// 体温記録リスト
///
/// Copied from [temperatureRecords].
@ProviderFor(temperatureRecords)
final temperatureRecordsProvider =
    AutoDisposeStreamProvider<List<TemperatureRecord>>.internal(
      temperatureRecords,
      name: r'temperatureRecordsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$temperatureRecordsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TemperatureRecordsRef =
    AutoDisposeStreamProviderRef<List<TemperatureRecord>>;
String _$exerciseRecordsHash() => r'3cdde3a989780c2bf297076ea7419497d31914c0';

/// 運動記録リスト
///
/// Copied from [exerciseRecords].
@ProviderFor(exerciseRecords)
final exerciseRecordsProvider =
    AutoDisposeStreamProvider<List<ExerciseRecord>>.internal(
      exerciseRecords,
      name: r'exerciseRecordsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$exerciseRecordsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ExerciseRecordsRef = AutoDisposeStreamProviderRef<List<ExerciseRecord>>;
String _$healthConnectStatusHash() =>
    r'5f4ac12a669dd9e5b538b93b455e33c2c7d75298';

/// Health Connect連携状態
///
/// Copied from [HealthConnectStatus].
@ProviderFor(HealthConnectStatus)
final healthConnectStatusProvider =
    AutoDisposeAsyncNotifierProvider<HealthConnectStatus, bool>.internal(
      HealthConnectStatus.new,
      name: r'healthConnectStatusProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$healthConnectStatusHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$HealthConnectStatus = AutoDisposeAsyncNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
