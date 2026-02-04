/// App constants
class AppConstants {
  AppConstants._();

  static const String appName = 'Health Management';
  
  // Exercise types
  static const List<String> exerciseTypes = [
    'ウォーキング',
    'ランニング',
    'サイクリング',
    '筋トレ',
    'ヨガ',
    '水泳',
    'その他',
  ];

  // Default goals
  static const int defaultStepGoal = 8000;
  static const double defaultWeightGoal = 60.0;
  static const int defaultExerciseGoal = 30; // minutes

  // Temperature range
  static const double minTemperature = 35.0;
  static const double maxTemperature = 42.0;
  static const double defaultTemperature = 36.5;

  // Weight range
  static const double minWeight = 20.0;
  static const double maxWeight = 200.0;
}
