import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/database.dart';
import '../../../../core/database/providers.dart';
import '../providers/store_provider.dart';

/// 店舗追加・編集画面
class StoreFormScreen extends ConsumerStatefulWidget {
  const StoreFormScreen({super.key, this.storeId});

  final int? storeId;

  bool get isEditing => storeId != null;

  @override
  ConsumerState<StoreFormScreen> createState() => _StoreFormScreenState();
}

class _StoreFormScreenState extends ConsumerState<StoreFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  Store? _store;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      _loadStore();
    }
  }

  Future<void> _loadStore() async {
    setState(() => _isLoading = true);
    final db = ref.read(databaseProvider);
    final stores = await db.getAllStores();
    final store = stores.firstWhere(
      (s) => s.id == widget.storeId,
      orElse: () => throw Exception('店舗が見つかりません'),
    );
    setState(() {
      _store = store;
      _nameController.text = store.name;
      _addressController.text = store.address ?? '';
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final notifier = ref.read(storeNotifierProvider.notifier);

      if (widget.isEditing && _store != null) {
        await notifier.updateStore(
          _store!.copyWith(
            name: _nameController.text.trim(),
            address: Value(_addressController.text.trim().isEmpty
                ? null
                : _addressController.text.trim()),
          ),
        );
      } else {
        await notifier.addStore(
          name: _nameController.text.trim(),
          address: _addressController.text.trim().isEmpty
              ? null
              : _addressController.text.trim(),
        );
      }

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('エラー: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? '店舗編集' : '店舗追加'),
      ),
      body: _isLoading && widget.isEditing && _store == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: '店舗名',
                        hintText: '例: イオン、ライフ、業務スーパー',
                        prefixIcon: Icon(Icons.store),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '店舗名を入力してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: '住所（オプション）',
                        hintText: '例: 東京都渋谷区...',
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 32),
                    FilledButton(
                      onPressed: _isLoading ? null : _submit,
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(widget.isEditing ? '更新' : '追加'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
