import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/database.dart';
import '../../../../core/database/providers.dart';
import '../providers/product_provider.dart';

/// 商品追加・編集画面
class ProductFormScreen extends ConsumerStatefulWidget {
  const ProductFormScreen({
    super.key,
    this.categoryId,
    this.productId,
  });

  final int? categoryId;
  final int? productId;

  bool get isEditing => productId != null;

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _memoController = TextEditingController();

  Product? _product;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      _loadProduct();
    }
  }

  Future<void> _loadProduct() async {
    setState(() => _isLoading = true);
    final db = ref.read(databaseProvider);
    // 全商品から検索
    final allProducts = <Product>[];
    final categories = await db.getAllCategories();
    for (final category in categories) {
      final categoryProducts = await db.getProductsByCategory(category.id);
      allProducts.addAll(categoryProducts);
    }
    final product = allProducts.firstWhere(
      (p) => p.id == widget.productId,
      orElse: () => throw Exception('商品が見つかりません'),
    );
    setState(() {
      _product = product;
      _nameController.text = product.name;
      _memoController.text = product.memo ?? '';
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final notifier = ref.read(productNotifierProvider.notifier);

      if (widget.isEditing && _product != null) {
        await notifier.updateProduct(
          _product!.copyWith(
            name: _nameController.text.trim(),
            memo: Value(_memoController.text.trim().isEmpty
                ? null
                : _memoController.text.trim()),
          ),
        );
      } else if (widget.categoryId != null) {
        await notifier.addProduct(
          categoryId: widget.categoryId!,
          name: _nameController.text.trim(),
          memo: _memoController.text.trim().isEmpty
              ? null
              : _memoController.text.trim(),
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
        title: Text(widget.isEditing ? '商品編集' : '商品追加'),
      ),
      body: _isLoading && widget.isEditing && _product == null
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
                        labelText: '商品名',
                        hintText: '例: 牛乳、食パン、洗剤',
                        prefixIcon: Icon(Icons.shopping_bag),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '商品名を入力してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _memoController,
                      decoration: const InputDecoration(
                        labelText: 'メモ（オプション）',
                        hintText: '例: 1L、8枚切り',
                        prefixIcon: Icon(Icons.note),
                      ),
                      maxLines: 3,
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
