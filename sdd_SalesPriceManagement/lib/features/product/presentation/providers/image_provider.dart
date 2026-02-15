import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/database.dart';
import '../../../../core/database/providers.dart';

part 'image_provider.g.dart';

/// 商品画像を取得するProvider
@riverpod
Future<ProductImage?> productImage(Ref ref, int productId) async {
  final db = ref.read(databaseProvider);
  return db.getProductImage(productId);
}

/// 商品画像操作のNotifier
@riverpod
class ImageNotifier extends _$ImageNotifier {
  @override
  FutureOr<void> build() {}

  /// カメラまたはギャラリーから画像を選択して保存
  Future<bool> pickAndSaveImage({
    required int productId,
    required ImageSource source,
  }) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (pickedFile == null) return false;

    try {
      // アプリ内のディレクトリに画像を保存
      final appDir = await getApplicationDocumentsDirectory();
      final imageDir = Directory(p.join(appDir.path, 'product_images'));
      if (!await imageDir.exists()) {
        await imageDir.create(recursive: true);
      }

      final fileName = 'product_${productId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedPath = p.join(imageDir.path, fileName);
      await File(pickedFile.path).copy(savedPath);

      // 既存画像がある場合は削除
      final db = ref.read(databaseProvider);
      final existing = await db.getProductImage(productId);
      if (existing != null) {
        // 古い画像ファイルを削除
        final oldFile = File(existing.imagePath);
        if (await oldFile.exists()) {
          await oldFile.delete();
        }
        await db.deleteProductImage(existing);
      }

      // データベースに登録
      await db.insertProductImage(
        ProductImagesCompanion.insert(
          productId: productId,
          imagePath: savedPath,
        ),
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  /// 画像を削除
  Future<void> deleteImage(int productId) async {
    final db = ref.read(databaseProvider);
    final existing = await db.getProductImage(productId);
    if (existing != null) {
      // ファイルを削除
      final file = File(existing.imagePath);
      if (await file.exists()) {
        await file.delete();
      }
      await db.deleteProductImage(existing);
    }
  }
}
