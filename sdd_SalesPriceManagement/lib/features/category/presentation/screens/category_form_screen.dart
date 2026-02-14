import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/database.dart';
import '../../../../core/database/providers.dart';
import '../providers/category_provider.dart';

/// カテゴリ追加・編集画面
class CategoryFormScreen extends ConsumerStatefulWidget {
  const CategoryFormScreen({super.key, this.categoryId});

  final int? categoryId;

  bool get isEditing => categoryId != null;

  @override
  ConsumerState<CategoryFormScreen> createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends ConsumerState<CategoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _sortOrderController = TextEditingController();
  
  Category? _category;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      _loadCategory();
    }
  }

  Future<void> _loadCategory() async {
    setState(() => _isLoading = true);
    final db = ref.read(databaseProvider);
    final categories = await db.getAllCategories();
    final category = categories.firstWhere(
      (c) => c.id == widget.categoryId,
      orElse: () => throw Exception('カテゴリが見つかりません'),
    );
    setState(() {
      _category = category;
      _nameController.text = category.name;
      _sortOrderController.text = category.sortOrder.toString();
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sortOrderController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final notifier = ref.read(categoryNotifierProvider.notifier);
      final sortOrder = int.tryParse(_sortOrderController.text) ?? 0;

      if (widget.isEditing && _category != null) {
        await notifier.updateCategory(
          _category!.copyWith(
            name: _nameController.text.trim(),
            sortOrder: sortOrder,
          ),
        );
      } else {
        await notifier.addCategory(
          _nameController.text.trim(),
          sortOrder: sortOrder,
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
        title: Text(widget.isEditing ? 'カテゴリ編集' : 'カテゴリ追加'),
      ),
      body: _isLoading && widget.isEditing && _category == null
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
                        labelText: 'カテゴリ名',
                        hintText: '例: 食品、日用品、飲料',
                        prefixIcon: Icon(Icons.category),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'カテゴリ名を入力してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _sortOrderController,
                      decoration: const InputDecoration(
                        labelText: '表示順（オプション）',
                        hintText: '小さい数字が先に表示されます',
                        prefixIcon: Icon(Icons.sort),
                      ),
                      keyboardType: TextInputType.number,
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
