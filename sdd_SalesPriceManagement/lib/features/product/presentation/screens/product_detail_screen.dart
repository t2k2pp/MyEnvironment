import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/database/database.dart';
import '../../../../core/database/providers.dart';
import '../../../price/presentation/providers/price_provider.dart';
import '../../../store/presentation/providers/store_provider.dart';
import '../../../analytics/presentation/widgets/price_chart_widget.dart';

/// 商品詳細画面（価格履歴とグラフ表示）
class ProductDetailScreen extends ConsumerStatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final int productId;

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  Product? _product;
  PricePeriod _selectedPeriod = PricePeriod.month;
  int? _selectedStoreId;

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
  Widget build(BuildContext context) {
    final priceRecordsAsync = ref.watch(priceRecordsByProductProvider(widget.productId));
    final storesAsync = ref.watch(storesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_product?.name ?? '商品詳細'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.pushNamed(
              'productEdit',
              pathParameters: {'id': widget.productId.toString()},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 商品情報カード
            if (_product != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.shopping_bag,
                              size: 32,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _product!.name,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                if (_product!.memo != null && _product!.memo!.isNotEmpty)
                                  Text(
                                    _product!.memo!,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: Theme.of(context).colorScheme.outline,
                                        ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            
            const SizedBox(height: 24),

            // 価格推移グラフ
            Text(
              '価格推移',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            
            // 期間選択
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: PricePeriod.values.map((period) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(period.label),
                      selected: _selectedPeriod == period,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _selectedPeriod = period);
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            
            const SizedBox(height: 8),

            // 店舗フィルタ
            storesAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (stores) {
                if (stores.isEmpty) return const SizedBox.shrink();
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text('全店舗'),
                        selected: _selectedStoreId == null,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => _selectedStoreId = null);
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      ...stores.map((store) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(store.name),
                            selected: _selectedStoreId == store.id,
                            onSelected: (selected) {
                              setState(() {
                                _selectedStoreId = selected ? store.id : null;
                              });
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // グラフ
            SizedBox(
              height: 200,
              child: PriceChartWidget(
                productId: widget.productId,
                period: _selectedPeriod,
                storeId: _selectedStoreId,
              ),
            ),

            const SizedBox(height: 24),

            // 価格履歴一覧
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '価格履歴',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),

            priceRecordsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Text('エラー: $error'),
              data: (records) {
                if (records.isEmpty) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              size: 48,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '価格記録がありません',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return Column(
                  children: records.take(10).map((record) {
                    return _PriceRecordTile(record: record);
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(
          'priceAdd',
          pathParameters: {'productId': widget.productId.toString()},
        ),
        icon: const Icon(Icons.add),
        label: const Text('価格を記録'),
      ),
    );
  }
}

class _PriceRecordTile extends ConsumerWidget {
  const _PriceRecordTile({required this.record});

  final PriceRecord record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storesAsync = ref.watch(storesStreamProvider);
    final dateFormat = DateFormat('yyyy/MM/dd');
    final priceFormat = NumberFormat('#,###');

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          child: Text(
            '¥',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          '¥${priceFormat.format(record.price)}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dateFormat.format(record.purchaseDate)),
            storesAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (stores) {
                final store = stores.cast<Store?>().firstWhere(
                      (s) => s?.id == record.storeId,
                      orElse: () => null,
                    );
                return Text(
                  store?.name ?? '不明な店舗',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              },
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
