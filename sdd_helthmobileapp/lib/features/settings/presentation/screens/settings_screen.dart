import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../health_data/presentation/providers/health_data_provider.dart';

/// 設定画面 - Health Connect連携、アプリ設定
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthConnectStatusAsync = ref.watch(healthConnectStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: ListView(
        children: [
          // Health Connect連携
          _SettingsSection(
            title: 'Health Connect連携',
            children: [
              healthConnectStatusAsync.when(
                data: (isAvailable) => _HealthConnectTile(
                  isAvailable: isAvailable,
                  onRequestPermission: () async {
                    final success = await ref
                        .read(healthConnectStatusProvider.notifier)
                        .requestPermissions();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            success ? '権限を取得しました' : '権限の取得に失敗しました',
                          ),
                          backgroundColor: success ? Colors.green : Colors.red,
                        ),
                      );
                    }
                  },
                ),
                loading: () => const ListTile(
                  leading: CircularProgressIndicator(),
                  title: Text('Health Connect状態を確認中...'),
                ),
                error: (e, _) => ListTile(
                  leading: const Icon(Icons.error, color: Colors.red),
                  title: const Text('Health Connect'),
                  subtitle: Text('エラー: $e'),
                ),
              ),
            ],
          ),

          const Divider(),

          // データ管理
          _SettingsSection(
            title: 'データ管理',
            children: [
              ListTile(
                leading: const Icon(Icons.download),
                title: const Text('データをエクスポート'),
                subtitle: const Text('健康データをCSVでエクスポート'),
                onTap: () {
                  // TODO: エクスポート機能
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('この機能は準備中です')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text('全データを削除',
                    style: TextStyle(color: Colors.red)),
                subtitle: const Text('すべての健康データを削除します'),
                onTap: () => _showDeleteConfirmation(context),
              ),
            ],
          ),

          const Divider(),

          // アプリ情報
          _SettingsSection(
            title: 'アプリ情報',
            children: [
              const ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('バージョン'),
                subtitle: Text('1.0.0'),
              ),
              ListTile(
                leading: const Icon(Icons.description_outlined),
                title: const Text('利用規約'),
                onTap: () {
                  // TODO: 利用規約画面
                },
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: const Text('プライバシーポリシー'),
                onTap: () {
                  // TODO: プライバシーポリシー画面
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('データ削除の確認'),
        content: const Text(
          'すべての健康データを削除しますか？この操作は取り消せません。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: データ削除処理
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('この機能は準備中です')),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('削除'),
          ),
        ],
      ),
    );
  }
}

/// Health Connect連携タイル
class _HealthConnectTile extends StatelessWidget {
  final bool isAvailable;
  final VoidCallback onRequestPermission;

  const _HealthConnectTile({
    required this.isAvailable,
    required this.onRequestPermission,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        isAvailable ? Icons.check_circle : Icons.warning,
        color: isAvailable ? Colors.green : Colors.orange,
      ),
      title: const Text('Health Connect'),
      subtitle: Text(
        isAvailable ? '連携済み' : '未連携',
      ),
      trailing: isAvailable
          ? null
          : FilledButton(
              onPressed: onRequestPermission,
              child: const Text('連携'),
            ),
    );
  }
}

/// 設定セクション
class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...children,
      ],
    );
  }
}
