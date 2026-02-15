import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/image_provider.dart' as img;

/// 商品画像表示Widget
/// 画像がある場合は表示、ない場合はプレースホルダーを表示
class ProductImageWidget extends ConsumerWidget {
  const ProductImageWidget({
    super.key,
    required this.productId,
    this.size = 56,
    this.borderRadius = 12,
    this.showEditButton = false,
  });

  final int productId;
  final double size;
  final double borderRadius;
  final bool showEditButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageAsync = ref.watch(img.productImageProvider(productId));

    return imageAsync.when(
      loading: () => _buildPlaceholder(context),
      error: (_, __) => _buildPlaceholder(context),
      data: (productImage) {
        if (productImage == null) {
          return showEditButton
              ? _buildAddImageButton(context, ref)
              : _buildPlaceholder(context);
        }

        final file = File(productImage.imagePath);
        return GestureDetector(
          onTap: showEditButton
              ? () => _showImageOptions(context, ref, hasImage: true)
              : null,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: file.existsSync()
                    ? Image.file(
                        file,
                        width: size,
                        height: size,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildPlaceholder(context),
                      )
                    : _buildPlaceholder(context),
              ),
              if (showEditButton)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.edit,
                      size: 14,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(
        Icons.shopping_bag,
        size: size * 0.5,
        color: Theme.of(context).colorScheme.onSecondaryContainer,
      ),
    );
  }

  Widget _buildAddImageButton(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _showImageOptions(context, ref, hasImage: false),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_a_photo,
              size: size * 0.35,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            const SizedBox(height: 2),
            Text(
              '写真',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageOptions(BuildContext context, WidgetRef ref, {required bool hasImage}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('カメラで撮影'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ref, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('ギャラリーから選択'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ref, ImageSource.gallery);
              },
            ),
            if (hasImage)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('写真を削除', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  ref.read(img.imageNotifierProvider.notifier).deleteImage(productId);
                  ref.invalidate(img.productImageProvider(productId));
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(WidgetRef ref, ImageSource source) async {
    final success = await ref.read(img.imageNotifierProvider.notifier).pickAndSaveImage(
          productId: productId,
          source: source,
        );
    if (success) {
      ref.invalidate(img.productImageProvider(productId));
    }
  }
}
