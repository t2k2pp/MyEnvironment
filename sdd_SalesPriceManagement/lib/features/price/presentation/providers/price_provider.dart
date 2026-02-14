import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/database.dart';
import '../../../../core/database/providers.dart';

part 'price_provider.g.dart';

/// 商品の価格履歴をストリームで監視
@riverpod
Stream<List<PriceRecord>> priceRecordsByProduct(Ref ref, int productId) {
  final db = ref.watch(databaseProvider);
  return db.watchPriceRecordsByProduct(productId);
}

/// 期間別の価格履歴を取得（グラフ用）
@riverpod
Future<List<PriceRecord>> priceRecordsByPeriod(
  Ref ref,
  int productId,
  PricePeriod period,
) async {
  final db = ref.read(databaseProvider);
  final now = DateTime.now();
  final from = switch (period) {
    PricePeriod.week => now.subtract(const Duration(days: 7)),
    PricePeriod.month => DateTime(now.year, now.month - 1, now.day),
    PricePeriod.threeMonths => now.subtract(const Duration(days: 90)),
    PricePeriod.year => DateTime(now.year - 1, now.month, now.day),
  };
  return db.getPriceRecordsByPeriod(productId, from, now);
}

/// 価格表示期間
enum PricePeriod {
  week('1週間'),
  month('1か月'),
  threeMonths('90日'),
  year('1年');

  const PricePeriod(this.label);
  final String label;
}

/// 価格記録操作のNotifier
@riverpod
class PriceNotifier extends _$PriceNotifier {
  @override
  FutureOr<void> build() {}

  /// 価格記録を追加
  Future<void> addPriceRecord({
    required int productId,
    required int storeId,
    required int price,
    required DateTime purchaseDate,
    String? memo,
  }) async {
    final db = ref.read(databaseProvider);
    await db.insertPriceRecord(
      PriceRecordsCompanion.insert(
        productId: productId,
        storeId: storeId,
        price: price,
        purchaseDate: purchaseDate,
        memo: Value(memo),
      ),
    );
  }

  /// 価格記録を更新
  Future<void> updatePriceRecord(PriceRecord record) async {
    final db = ref.read(databaseProvider);
    await db.updatePriceRecord(record);
  }

  /// 価格記録を削除
  Future<void> deletePriceRecord(PriceRecord record) async {
    final db = ref.read(databaseProvider);
    await db.deletePriceRecord(record);
  }
}
