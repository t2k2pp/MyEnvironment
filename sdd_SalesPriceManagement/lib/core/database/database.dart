import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables.dart';

part 'database.g.dart';

/// アプリケーションデータベース
/// Driftを使用したSQLiteデータベース
@DriftDatabase(tables: [Categories, Products, Stores, PriceRecords, ProductImages])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// テスト用コンストラクタ（インメモリDB）
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  // ===== カテゴリ操作 =====

  /// 全カテゴリを取得（ソート順）
  Future<List<Category>> getAllCategories() {
    return (select(categories)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).get();
  }

  /// カテゴリをストリームで監視
  Stream<List<Category>> watchAllCategories() {
    return (select(categories)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).watch();
  }

  /// カテゴリを追加
  Future<int> insertCategory(CategoriesCompanion category) {
    return into(categories).insert(category);
  }

  /// カテゴリを更新
  Future<bool> updateCategory(Category category) {
    return update(categories).replace(category);
  }

  /// カテゴリを削除
  Future<int> deleteCategory(Category category) {
    return delete(categories).delete(category);
  }

  // ===== 商品操作 =====

  /// カテゴリ別の商品を取得
  Future<List<Product>> getProductsByCategory(int categoryId) {
    return (select(products)..where((t) => t.categoryId.equals(categoryId))).get();
  }

  /// カテゴリ別の商品をストリームで監視
  Stream<List<Product>> watchProductsByCategory(int categoryId) {
    return (select(products)..where((t) => t.categoryId.equals(categoryId))).watch();
  }

  /// 商品を追加
  Future<int> insertProduct(ProductsCompanion product) {
    return into(products).insert(product);
  }

  /// 商品を更新
  Future<bool> updateProduct(Product product) {
    return update(products).replace(product);
  }

  /// 商品を削除
  Future<int> deleteProduct(Product product) {
    return delete(products).delete(product);
  }

  /// 商品を検索
  Future<List<Product>> searchProducts(String query) {
    return (select(products)..where((t) => t.name.like('%$query%'))).get();
  }

  // ===== 店舗操作 =====

  /// 全店舗を取得
  Future<List<Store>> getAllStores() {
    return (select(stores)..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
  }

  /// 店舗をストリームで監視
  Stream<List<Store>> watchAllStores() {
    return (select(stores)..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();
  }

  /// 店舗を追加
  Future<int> insertStore(StoresCompanion store) {
    return into(stores).insert(store);
  }

  /// 店舗を更新
  Future<bool> updateStore(Store store) {
    return update(stores).replace(store);
  }

  /// 店舗を削除
  Future<int> deleteStore(Store store) {
    return delete(stores).delete(store);
  }

  // ===== 価格記録操作 =====

  /// 商品の価格履歴を取得
  Future<List<PriceRecord>> getPriceRecordsByProduct(int productId) {
    return (select(priceRecords)
          ..where((t) => t.productId.equals(productId))
          ..orderBy([(t) => OrderingTerm.desc(t.purchaseDate)]))
        .get();
  }

  /// 商品の価格履歴をストリームで監視
  Stream<List<PriceRecord>> watchPriceRecordsByProduct(int productId) {
    return (select(priceRecords)
          ..where((t) => t.productId.equals(productId))
          ..orderBy([(t) => OrderingTerm.desc(t.purchaseDate)]))
        .watch();
  }

  /// 店舗別の価格履歴を取得
  Future<List<PriceRecord>> getPriceRecordsByProductAndStore(int productId, int storeId) {
    return (select(priceRecords)
          ..where((t) => t.productId.equals(productId) & t.storeId.equals(storeId))
          ..orderBy([(t) => OrderingTerm.desc(t.purchaseDate)]))
        .get();
  }

  /// 期間指定で価格履歴を取得
  Future<List<PriceRecord>> getPriceRecordsByPeriod(int productId, DateTime from, DateTime to) {
    return (select(priceRecords)
          ..where((t) =>
              t.productId.equals(productId) &
              t.purchaseDate.isBiggerOrEqualValue(from) &
              t.purchaseDate.isSmallerOrEqualValue(to))
          ..orderBy([(t) => OrderingTerm.asc(t.purchaseDate)]))
        .get();
  }

  /// 価格記録を追加
  Future<int> insertPriceRecord(PriceRecordsCompanion record) {
    return into(priceRecords).insert(record);
  }

  /// 価格記録を更新
  Future<bool> updatePriceRecord(PriceRecord record) {
    return update(priceRecords).replace(record);
  }

  /// 価格記録を削除
  Future<int> deletePriceRecord(PriceRecord record) {
    return delete(priceRecords).delete(record);
  }

  // ===== 商品画像操作 =====

  /// 商品の画像を取得
  Future<ProductImage?> getProductImage(int productId) {
    return (select(productImages)..where((t) => t.productId.equals(productId))).getSingleOrNull();
  }

  /// 商品画像を追加
  Future<int> insertProductImage(ProductImagesCompanion image) {
    return into(productImages).insert(image);
  }

  /// 商品画像を削除
  Future<int> deleteProductImage(ProductImage image) {
    return delete(productImages).delete(image);
  }
}

/// データベース接続を開く
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sales_price.db'));
    return NativeDatabase.createInBackground(file);
  });
}
