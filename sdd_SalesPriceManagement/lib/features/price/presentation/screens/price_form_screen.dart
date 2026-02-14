import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/database/database.dart';
import '../../../../core/database/providers.dart';
import '../../../store/presentation/providers/store_provider.dart';
import '../providers/price_provider.dart';

/// 価格記録追加画面
class PriceFormScreen extends ConsumerStatefulWidget {
  const PriceFormScreen({super.key, required this.productId});

  final int productId;

  @override
  ConsumerState<PriceFormScreen> createState() => _PriceFormScreenState();
}

class _PriceFormScreenState extends ConsumerState<PriceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _memoController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  int? _selectedStoreId;
  bool _isLoading = false;
  Product? _product;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    final db = ref.read(databaseProvider);
    final categories = await db.getAllCategories();
    for (final category in categories) {
      final products = await db.getProductsByCategory(category.id);
      final product = products.cast<Product?>().firstWhere(
            (p) => p?.id == widget.productId,
            orElse: () => null,
          );
      if (product != null) {
        setState(() => _product = product);
        return;
      }
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: const Locale('ja'),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedStoreId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('店舗を選択してください')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final price = int.parse(_priceController.text.replaceAll(',', ''));
      await ref.read(priceNotifierProvider.notifier).addPriceRecord(
            productId: widget.productId,
            storeId: _selectedStoreId!,
            price: price,
            purchaseDate: _selectedDate,
            memo: _memoController.text.trim().isEmpty
                ? null
                : _memoController.text.trim(),
          );

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
    final storesAsync = ref.watch(storesStreamProvider);
    final dateFormat = DateFormat('yyyy年MM月dd日');

    return Scaffold(
      appBar: AppBar(
        title: Text(_product != null ? '${_product!.name}の価格を記録' : '価格を記録'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 価格入力
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: '価格（円）',
                  hintText: '例: 198',
                  prefixIcon: Icon(Icons.currency_yen),
                  suffix: Text('円'),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '価格を入力してください';
                  }
                  final price = int.tryParse(value.replaceAll(',', ''));
                  if (price == null || price <= 0) {
                    return '正しい価格を入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 日付選択
              Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('購入日'),
                  subtitle: Text(dateFormat.format(_selectedDate)),
                  trailing: const Icon(Icons.edit),
                  onTap: _selectDate,
                ),
              ),
              const SizedBox(height: 16),

              // 店舗選択
              Text(
                '店舗を選択',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              storesAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Text('エラー: $error'),
                data: (stores) {
                  if (stores.isEmpty) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.add),
                        title: const Text('店舗を追加'),
                        onTap: () async {
                          await context.pushNamed('storeAdd');
                        },
                      ),
                    );
                  }
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...stores.map((store) {
                        return ChoiceChip(
                          label: Text(store.name),
                          selected: _selectedStoreId == store.id,
                          onSelected: (selected) {
                            setState(() {
                              _selectedStoreId = selected ? store.id : null;
                            });
                          },
                        );
                      }),
                      ActionChip(
                        avatar: const Icon(Icons.add, size: 18),
                        label: const Text('店舗を追加'),
                        onPressed: () async {
                          await context.pushNamed('storeAdd');
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),

              // メモ入力
              TextFormField(
                controller: _memoController,
                decoration: const InputDecoration(
                  labelText: 'メモ（オプション）',
                  hintText: '例: セール価格、タイムセール',
                  prefixIcon: Icon(Icons.note),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 32),

              // 送信ボタン
              FilledButton(
                onPressed: _isLoading ? null : _submit,
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('記録する'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
