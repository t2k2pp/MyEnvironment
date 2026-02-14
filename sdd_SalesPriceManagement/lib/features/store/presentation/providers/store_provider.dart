import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/database.dart';
import '../../../../core/database/providers.dart';

part 'store_provider.g.dart';

/// 店舗一覧をストリームで監視
@riverpod
Stream<List<Store>> storesStream(Ref ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllStores();
}

/// 店舗操作のNotifier
@riverpod
class StoreNotifier extends _$StoreNotifier {
  @override
  FutureOr<void> build() {}

  /// 店舗を追加
  Future<int> addStore({required String name, String? address}) async {
    final db = ref.read(databaseProvider);
    return db.insertStore(
      StoresCompanion.insert(
        name: name,
        address: Value(address),
      ),
    );
  }

  /// 店舗を更新
  Future<void> updateStore(Store store) async {
    final db = ref.read(databaseProvider);
    await db.updateStore(store);
  }

  /// 店舗を削除
  Future<void> deleteStore(Store store) async {
    final db = ref.read(databaseProvider);
    await db.deleteStore(store);
  }
}
