import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:sales_price_management/core/database/database.dart';

/// テスト用のインメモリデータベースを作成
AppDatabase _createTestDb() {
  return AppDatabase.forTesting(NativeDatabase.memory());
}

void main() {
  late AppDatabase db;

  setUp(() {
    db = _createTestDb();
  });

  tearDown(() async {
    await db.close();
  });

  group('カテゴリ操作', () {
    test('カテゴリを追加して取得できる', () async {
      await db.insertCategory(
        CategoriesCompanion.insert(
          name: '食料品',
          sortOrder: const Value(0),
        ),
      );

      final categories = await db.getAllCategories();
      expect(categories, hasLength(1));
      expect(categories.first.name, '食料品');
    });

    test('複数カテゴリをソート順で取得できる', () async {
      await db.insertCategory(
        CategoriesCompanion.insert(name: '日用品', sortOrder: const Value(2)),
      );
      await db.insertCategory(
        CategoriesCompanion.insert(name: '食料品', sortOrder: const Value(1)),
      );
      await db.insertCategory(
        CategoriesCompanion.insert(name: '飲料', sortOrder: const Value(0)),
      );

      final categories = await db.getAllCategories();
      expect(categories, hasLength(3));
      expect(categories[0].name, '飲料');
      expect(categories[1].name, '食料品');
      expect(categories[2].name, '日用品');
    });

    test('カテゴリを更新できる', () async {
      final id = await db.insertCategory(
        CategoriesCompanion.insert(name: '食料品'),
      );

      final categories = await db.getAllCategories();
      final category = categories.first;
      await db.updateCategory(category.copyWith(name: '食品'));

      final updated = await db.getAllCategories();
      expect(updated.first.name, '食品');
    });

    test('カテゴリを削除できる', () async {
      await db.insertCategory(
        CategoriesCompanion.insert(name: '食料品'),
      );

      final categories = await db.getAllCategories();
      expect(categories, hasLength(1));

      await db.deleteCategory(categories.first);

      final afterDelete = await db.getAllCategories();
      expect(afterDelete, isEmpty);
    });
  });

  group('商品操作', () {
    late int categoryId;

    setUp(() async {
      categoryId = await db.insertCategory(
        CategoriesCompanion.insert(name: 'テストカテゴリ'),
      );
    });

    test('商品を追加して取得できる', () async {
      await db.insertProduct(
        ProductsCompanion.insert(
          categoryId: categoryId,
          name: '牛乳',
          memo: const Value('1L'),
        ),
      );

      final products = await db.getProductsByCategory(categoryId);
      expect(products, hasLength(1));
      expect(products.first.name, '牛乳');
      expect(products.first.memo, '1L');
    });

    test('商品を検索できる', () async {
      await db.insertProduct(
        ProductsCompanion.insert(categoryId: categoryId, name: '牛乳'),
      );
      await db.insertProduct(
        ProductsCompanion.insert(categoryId: categoryId, name: '食パン'),
      );
      await db.insertProduct(
        ProductsCompanion.insert(categoryId: categoryId, name: '牛肉'),
      );

      final results = await db.searchProducts('牛');
      expect(results, hasLength(2));
    });

    test('カテゴリ別に商品を取得できる', () async {
      final categoryId2 = await db.insertCategory(
        CategoriesCompanion.insert(name: 'カテゴリ2'),
      );

      await db.insertProduct(
        ProductsCompanion.insert(categoryId: categoryId, name: '商品A'),
      );
      await db.insertProduct(
        ProductsCompanion.insert(categoryId: categoryId2, name: '商品B'),
      );

      final products1 = await db.getProductsByCategory(categoryId);
      expect(products1, hasLength(1));
      expect(products1.first.name, '商品A');

      final products2 = await db.getProductsByCategory(categoryId2);
      expect(products2, hasLength(1));
      expect(products2.first.name, '商品B');
    });
  });

  group('店舗操作', () {
    test('店舗を追加して取得できる', () async {
      await db.insertStore(
        StoresCompanion.insert(
          name: 'イオン',
          address: const Value('東京都渋谷区'),
        ),
      );

      final stores = await db.getAllStores();
      expect(stores, hasLength(1));
      expect(stores.first.name, 'イオン');
      expect(stores.first.address, '東京都渋谷区');
    });

    test('店舗名でソートされる', () async {
      await db.insertStore(StoresCompanion.insert(name: 'ライフ'));
      await db.insertStore(StoresCompanion.insert(name: 'イオン'));
      await db.insertStore(StoresCompanion.insert(name: 'マルエツ'));

      final stores = await db.getAllStores();
      expect(stores, hasLength(3));
      // 名前順ソート
      expect(stores[0].name, 'イオン');
      expect(stores[1].name, 'マルエツ');
      expect(stores[2].name, 'ライフ');
    });
  });

  group('価格記録操作', () {
    late int productId;
    late int storeId;

    setUp(() async {
      final categoryId = await db.insertCategory(
        CategoriesCompanion.insert(name: 'テストカテゴリ'),
      );
      productId = await db.insertProduct(
        ProductsCompanion.insert(categoryId: categoryId, name: '牛乳'),
      );
      storeId = await db.insertStore(
        StoresCompanion.insert(name: 'テスト店舗'),
      );
    });

    test('価格記録を追加して取得できる', () async {
      await db.insertPriceRecord(
        PriceRecordsCompanion.insert(
          productId: productId,
          storeId: storeId,
          price: 198,
          purchaseDate: DateTime(2024, 1, 15),
        ),
      );

      final records = await db.getPriceRecordsByProduct(productId);
      expect(records, hasLength(1));
      expect(records.first.price, 198);
    });

    test('期間指定で価格記録を取得できる', () async {
      await db.insertPriceRecord(
        PriceRecordsCompanion.insert(
          productId: productId, storeId: storeId,
          price: 198, purchaseDate: DateTime(2024, 1, 10),
        ),
      );
      await db.insertPriceRecord(
        PriceRecordsCompanion.insert(
          productId: productId, storeId: storeId,
          price: 178, purchaseDate: DateTime(2024, 1, 20),
        ),
      );
      await db.insertPriceRecord(
        PriceRecordsCompanion.insert(
          productId: productId, storeId: storeId,
          price: 210, purchaseDate: DateTime(2024, 2, 5),
        ),
      );

      final records = await db.getPriceRecordsByPeriod(
        productId,
        DateTime(2024, 1, 15),
        DateTime(2024, 2, 1),
      );

      expect(records, hasLength(1));
      expect(records.first.price, 178);
    });

    test('店舗別に価格記録を取得できる', () async {
      final storeId2 = await db.insertStore(
        StoresCompanion.insert(name: '別店舗'),
      );

      await db.insertPriceRecord(
        PriceRecordsCompanion.insert(
          productId: productId, storeId: storeId,
          price: 198, purchaseDate: DateTime(2024, 1, 15),
        ),
      );
      await db.insertPriceRecord(
        PriceRecordsCompanion.insert(
          productId: productId, storeId: storeId2,
          price: 168, purchaseDate: DateTime(2024, 1, 16),
        ),
      );

      final records = await db.getPriceRecordsByProductAndStore(productId, storeId);
      expect(records, hasLength(1));
      expect(records.first.price, 198);
    });

    test('新しい順で価格記録が取得される', () async {
      await db.insertPriceRecord(
        PriceRecordsCompanion.insert(
          productId: productId, storeId: storeId,
          price: 198, purchaseDate: DateTime(2024, 1, 10),
        ),
      );
      await db.insertPriceRecord(
        PriceRecordsCompanion.insert(
          productId: productId, storeId: storeId,
          price: 178, purchaseDate: DateTime(2024, 1, 20),
        ),
      );

      final records = await db.getPriceRecordsByProduct(productId);
      expect(records, hasLength(2));
      expect(records.first.price, 178); // 最新が最初
      expect(records.last.price, 198);
    });
  });

  group('商品画像操作', () {
    late int productId;

    setUp(() async {
      final categoryId = await db.insertCategory(
        CategoriesCompanion.insert(name: 'テストカテゴリ'),
      );
      productId = await db.insertProduct(
        ProductsCompanion.insert(categoryId: categoryId, name: '牛乳'),
      );
    });

    test('商品画像を追加して取得できる', () async {
      await db.insertProductImage(
        ProductImagesCompanion.insert(
          productId: productId,
          imagePath: '/path/to/image.jpg',
        ),
      );

      final image = await db.getProductImage(productId);
      expect(image, isNotNull);
      expect(image!.imagePath, '/path/to/image.jpg');
    });

    test('画像が無い場合nullを返す', () async {
      final image = await db.getProductImage(productId);
      expect(image, isNull);
    });
  });
}
