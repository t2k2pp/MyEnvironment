// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productImageHash() => r'00351d36e148fb0452835d0e1f30366977a0bf2d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// 商品画像を取得するProvider
///
/// Copied from [productImage].
@ProviderFor(productImage)
const productImageProvider = ProductImageFamily();

/// 商品画像を取得するProvider
///
/// Copied from [productImage].
class ProductImageFamily extends Family<AsyncValue<ProductImage?>> {
  /// 商品画像を取得するProvider
  ///
  /// Copied from [productImage].
  const ProductImageFamily();

  /// 商品画像を取得するProvider
  ///
  /// Copied from [productImage].
  ProductImageProvider call(int productId) {
    return ProductImageProvider(productId);
  }

  @override
  ProductImageProvider getProviderOverride(
    covariant ProductImageProvider provider,
  ) {
    return call(provider.productId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productImageProvider';
}

/// 商品画像を取得するProvider
///
/// Copied from [productImage].
class ProductImageProvider extends AutoDisposeFutureProvider<ProductImage?> {
  /// 商品画像を取得するProvider
  ///
  /// Copied from [productImage].
  ProductImageProvider(int productId)
    : this._internal(
        (ref) => productImage(ref as ProductImageRef, productId),
        from: productImageProvider,
        name: r'productImageProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$productImageHash,
        dependencies: ProductImageFamily._dependencies,
        allTransitiveDependencies:
            ProductImageFamily._allTransitiveDependencies,
        productId: productId,
      );

  ProductImageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final int productId;

  @override
  Override overrideWith(
    FutureOr<ProductImage?> Function(ProductImageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductImageProvider._internal(
        (ref) => create(ref as ProductImageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ProductImage?> createElement() {
    return _ProductImageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductImageProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductImageRef on AutoDisposeFutureProviderRef<ProductImage?> {
  /// The parameter `productId` of this provider.
  int get productId;
}

class _ProductImageProviderElement
    extends AutoDisposeFutureProviderElement<ProductImage?>
    with ProductImageRef {
  _ProductImageProviderElement(super.provider);

  @override
  int get productId => (origin as ProductImageProvider).productId;
}

String _$imageNotifierHash() => r'd2b6e79bbaaed845b47a87437e07d431beec8dd6';

/// 商品画像操作のNotifier
///
/// Copied from [ImageNotifier].
@ProviderFor(ImageNotifier)
final imageNotifierProvider =
    AutoDisposeAsyncNotifierProvider<ImageNotifier, void>.internal(
      ImageNotifier.new,
      name: r'imageNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$imageNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ImageNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
