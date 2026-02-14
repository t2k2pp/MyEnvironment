import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/database.dart';
import '../../../../core/database/providers.dart';

part 'product_provider.g.dart';

/// カテゴリ別の商品一覧をストリームで監視
@riverpod
Stream<List<Product>> productsByCategory(Ref ref, int categoryId) {
  final db = ref.watch(databaseProvider);
  return db.watchProductsByCategory(categoryId);
}

/// 商品検索
@riverpod
Future<List<Product>> searchProducts(Ref ref, String query) async {
  if (query.isEmpty) return [];
  final db = ref.read(databaseProvider);
  return db.searchProducts(query);
}

/// 商品操作のNotifier
@riverpod
class ProductNotifier extends _$ProductNotifier {
  @override
  FutureOr<void> build() {}

  /// 商品を追加
  Future<int> addProduct({
    required int categoryId,
    required String name,
    String? memo,
  }) async {
    final db = ref.read(databaseProvider);
    return db.insertProduct(
      ProductsCompanion.insert(
        categoryId: categoryId,
        name: name,
        memo: Value(memo),
      ),
    );
  }

  /// 商品を更新
  Future<void> updateProduct(Product product) async {
    final db = ref.read(databaseProvider);
    await db.updateProduct(product);
  }

  /// 商品を削除
  Future<void> deleteProduct(Product product) async {
    final db = ref.read(databaseProvider);
    await db.deleteProduct(product);
  }
}
