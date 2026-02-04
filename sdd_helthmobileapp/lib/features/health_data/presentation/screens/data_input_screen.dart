import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/weight_record.dart';
import '../../domain/entities/temperature_record.dart';
import '../../domain/entities/exercise_record.dart';
import '../providers/health_data_provider.dart';

/// データ入力画面 - 体重、体温、運動を記録
class DataInputScreen extends ConsumerStatefulWidget {
  const DataInputScreen({super.key});

  @override
  ConsumerState<DataInputScreen> createState() => _DataInputScreenState();
}

class _DataInputScreenState extends ConsumerState<DataInputScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _uuid = const Uuid();

  // 体重入力
  final _weightController = TextEditingController();

  // 体温入力
  final _temperatureController = TextEditingController();

  // 運動入力
  String _selectedExerciseType = AppConstants.exerciseTypes.first;
  final _durationController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _temperatureController.text = AppConstants.defaultTemperature.toString();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _weightController.dispose();
    _temperatureController.dispose();
    _durationController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('データ入力'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.monitor_weight), text: '体重'),
            Tab(icon: Icon(Icons.thermostat), text: '体温'),
            Tab(icon: Icon(Icons.fitness_center), text: '運動'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildWeightTab(),
          _buildTemperatureTab(),
          _buildExerciseTab(),
        ],
      ),
    );
  }

  /// 体重入力タブ
  Widget _buildWeightTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '体重を記録',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: '体重',
              suffixText: 'kg',
              hintText: '60.0',
            ),
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: _saveWeight,
            icon: const Icon(Icons.save),
            label: const Text('保存'),
          ),
        ],
      ),
    );
  }

  /// 体温入力タブ
  Widget _buildTemperatureTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '体温を記録',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _temperatureController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: '体温',
              suffixText: '℃',
              hintText: '36.5',
            ),
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: _saveTemperature,
            icon: const Icon(Icons.save),
            label: const Text('保存'),
          ),
        ],
      ),
    );
  }

  /// 運動入力タブ
  Widget _buildExerciseTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '運動を記録',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          DropdownButtonFormField<String>(
            value: _selectedExerciseType,
            decoration: const InputDecoration(
              labelText: '運動の種類',
            ),
            items: AppConstants.exerciseTypes.map((type) {
              return DropdownMenuItem(value: type, child: Text(type));
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedExerciseType = value);
              }
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _durationController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: '運動時間',
              suffixText: '分',
              hintText: '30',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _noteController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'メモ（任意）',
              hintText: '運動の内容など',
            ),
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: _saveExercise,
            icon: const Icon(Icons.save),
            label: const Text('保存'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveWeight() async {
    final weightText = _weightController.text.trim();
    if (weightText.isEmpty) {
      _showError('体重を入力してください');
      return;
    }

    final weight = double.tryParse(weightText);
    if (weight == null ||
        weight < AppConstants.minWeight ||
        weight > AppConstants.maxWeight) {
      _showError('正しい体重を入力してください');
      return;
    }

    final record = WeightRecord(
      id: _uuid.v4(),
      date: DateTime.now(),
      weight: weight,
      createdAt: DateTime.now(),
    );

    try {
      await ref.read(healthDataRepositoryProvider).saveWeightRecord(record);
      _weightController.clear();
      _showSuccess('体重を保存しました');
    } catch (e) {
      _showError('保存に失敗しました');
    }
  }

  Future<void> _saveTemperature() async {
    final tempText = _temperatureController.text.trim();
    if (tempText.isEmpty) {
      _showError('体温を入力してください');
      return;
    }

    final temperature = double.tryParse(tempText);
    if (temperature == null ||
        temperature < AppConstants.minTemperature ||
        temperature > AppConstants.maxTemperature) {
      _showError('正しい体温を入力してください');
      return;
    }

    final record = TemperatureRecord(
      id: _uuid.v4(),
      date: DateTime.now(),
      temperature: temperature,
      createdAt: DateTime.now(),
    );

    try {
      await ref.read(healthDataRepositoryProvider).saveTemperatureRecord(record);
      _temperatureController.text = AppConstants.defaultTemperature.toString();
      _showSuccess('体温を保存しました');
    } catch (e) {
      _showError('保存に失敗しました');
    }
  }

  Future<void> _saveExercise() async {
    final durationText = _durationController.text.trim();
    if (durationText.isEmpty) {
      _showError('運動時間を入力してください');
      return;
    }

    final duration = int.tryParse(durationText);
    if (duration == null || duration <= 0) {
      _showError('正しい運動時間を入力してください');
      return;
    }

    final record = ExerciseRecord(
      id: _uuid.v4(),
      date: DateTime.now(),
      exerciseType: _selectedExerciseType,
      durationMinutes: duration,
      note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
      createdAt: DateTime.now(),
    );

    try {
      await ref.read(healthDataRepositoryProvider).saveExerciseRecord(record);
      _durationController.clear();
      _noteController.clear();
      _showSuccess('運動を保存しました');
    } catch (e) {
      _showError('保存に失敗しました');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
