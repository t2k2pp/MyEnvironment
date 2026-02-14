import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/database.dart';
import '../../../../core/database/providers.dart';

part 'category_provider.g.dart';

/// カテゴリ一覧をストリームで監視
@riverpod
Stream<List<Category>> categoriesStream(Ref ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllCategories();
}

/// カテゴリ操作のNotifier
@riverpod
class CategoryNotifier extends _$CategoryNotifier {
  @override
  FutureOr<void> build() {}

  /// カテゴリを追加
  Future<void> addCategory(String name, {int? sortOrder}) async {
    final db = ref.read(databaseProvider);
    await db.insertCategory(
      CategoriesCompanion.insert(
        name: name,
        sortOrder: Value(sortOrder ?? 0),
      ),
    );
  }

  /// カテゴリを更新
  Future<void> updateCategory(Category category) async {
    final db = ref.read(databaseProvider);
    await db.updateCategory(category);
  }

  /// カテゴリを削除
  Future<void> deleteCategory(Category category) async {
    final db = ref.read(databaseProvider);
    await db.deleteCategory(category);
  }
}
