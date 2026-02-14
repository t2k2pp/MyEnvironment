import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/database.dart';
import '../../../../core/database/providers.dart';
import '../providers/product_provider.dart';

/// 商品一覧画面（カテゴリ別）
class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key, required this.categoryId});

  final int categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsByCategoryProvider(categoryId));

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: _getCategoryName(ref),
          builder: (context, snapshot) {
            return Text(snapshot.data ?? '商品一覧');
          },
        ),
      ),
      body: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('エラー: $error'),
        ),
        data: (products) {
          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '商品がありません',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text('右下の+ボタンで商品を追加してください'),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return _ProductCard(product: product);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(
          'productAdd',
          pathParameters: {'categoryId': categoryId.toString()},
        ),
        icon: const Icon(Icons.add),
        label: const Text('商品追加'),
      ),
    );
  }

  Future<String> _getCategoryName(WidgetRef ref) async {
    final db = ref.read(databaseProvider);
    final categories = await db.getAllCategories();
    final category = categories.firstWhere(
      (c) => c.id == categoryId,
      orElse: () => throw Exception('カテゴリが見つかりません'),
    );
    return category.name;
  }
}

class _ProductCard extends ConsumerWidget {
  const _ProductCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.shopping_bag,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
        title: Text(
          product.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: product.memo != null && product.memo!.isNotEmpty
            ? Text(
                product.memo!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.pushNamed(
          'productDetail',
          pathParameters: {'id': product.id.toString()},
        ),
      ),
    );
  }
}
