// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$priceRecordsByProductHash() =>
    r'988b02281632b907f6d48b38fbaf528a2e2bbbcb';

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

/// 商品の価格履歴をストリームで監視
///
/// Copied from [priceRecordsByProduct].
@ProviderFor(priceRecordsByProduct)
const priceRecordsByProductProvider = PriceRecordsByProductFamily();

/// 商品の価格履歴をストリームで監視
///
/// Copied from [priceRecordsByProduct].
class PriceRecordsByProductFamily
    extends Family<AsyncValue<List<PriceRecord>>> {
  /// 商品の価格履歴をストリームで監視
  ///
  /// Copied from [priceRecordsByProduct].
  const PriceRecordsByProductFamily();

  /// 商品の価格履歴をストリームで監視
  ///
  /// Copied from [priceRecordsByProduct].
  PriceRecordsByProductProvider call(int productId) {
    return PriceRecordsByProductProvider(productId);
  }

  @override
  PriceRecordsByProductProvider getProviderOverride(
    covariant PriceRecordsByProductProvider provider,
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
  String? get name => r'priceRecordsByProductProvider';
}

/// 商品の価格履歴をストリームで監視
///
/// Copied from [priceRecordsByProduct].
class PriceRecordsByProductProvider
    extends AutoDisposeStreamProvider<List<PriceRecord>> {
  /// 商品の価格履歴をストリームで監視
  ///
  /// Copied from [priceRecordsByProduct].
  PriceRecordsByProductProvider(int productId)
    : this._internal(
        (ref) =>
            priceRecordsByProduct(ref as PriceRecordsByProductRef, productId),
        from: priceRecordsByProductProvider,
        name: r'priceRecordsByProductProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$priceRecordsByProductHash,
        dependencies: PriceRecordsByProductFamily._dependencies,
        allTransitiveDependencies:
            PriceRecordsByProductFamily._allTransitiveDependencies,
        productId: productId,
      );

  PriceRecordsByProductProvider._internal(
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
    Stream<List<PriceRecord>> Function(PriceRecordsByProductRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PriceRecordsByProductProvider._internal(
        (ref) => create(ref as PriceRecordsByProductRef),
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
  AutoDisposeStreamProviderElement<List<PriceRecord>> createElement() {
    return _PriceRecordsByProductProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PriceRecordsByProductProvider &&
        other.productId == productId;
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
mixin PriceRecordsByProductRef
    on AutoDisposeStreamProviderRef<List<PriceRecord>> {
  /// The parameter `productId` of this provider.
  int get productId;
}

class _PriceRecordsByProductProviderElement
    extends AutoDisposeStreamProviderElement<List<PriceRecord>>
    with PriceRecordsByProductRef {
  _PriceRecordsByProductProviderElement(super.provider);

  @override
  int get productId => (origin as PriceRecordsByProductProvider).productId;
}

String _$priceRecordsByPeriodHash() =>
    r'04e95d97239f00d8c5a23cf4011daf69d104fce7';

/// 期間別の価格履歴を取得（グラフ用）
///
/// Copied from [priceRecordsByPeriod].
@ProviderFor(priceRecordsByPeriod)
const priceRecordsByPeriodProvider = PriceRecordsByPeriodFamily();

/// 期間別の価格履歴を取得（グラフ用）
///
/// Copied from [priceRecordsByPeriod].
class PriceRecordsByPeriodFamily extends Family<AsyncValue<List<PriceRecord>>> {
  /// 期間別の価格履歴を取得（グラフ用）
  ///
  /// Copied from [priceRecordsByPeriod].
  const PriceRecordsByPeriodFamily();

  /// 期間別の価格履歴を取得（グラフ用）
  ///
  /// Copied from [priceRecordsByPeriod].
  PriceRecordsByPeriodProvider call(int productId, PricePeriod period) {
    return PriceRecordsByPeriodProvider(productId, period);
  }

  @override
  PriceRecordsByPeriodProvider getProviderOverride(
    covariant PriceRecordsByPeriodProvider provider,
  ) {
    return call(provider.productId, provider.period);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'priceRecordsByPeriodProvider';
}

/// 期間別の価格履歴を取得（グラフ用）
///
/// Copied from [priceRecordsByPeriod].
class PriceRecordsByPeriodProvider
    extends AutoDisposeFutureProvider<List<PriceRecord>> {
  /// 期間別の価格履歴を取得（グラフ用）
  ///
  /// Copied from [priceRecordsByPeriod].
  PriceRecordsByPeriodProvider(int productId, PricePeriod period)
    : this._internal(
        (ref) => priceRecordsByPeriod(
          ref as PriceRecordsByPeriodRef,
          productId,
          period,
        ),
        from: priceRecordsByPeriodProvider,
        name: r'priceRecordsByPeriodProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$priceRecordsByPeriodHash,
        dependencies: PriceRecordsByPeriodFamily._dependencies,
        allTransitiveDependencies:
            PriceRecordsByPeriodFamily._allTransitiveDependencies,
        productId: productId,
        period: period,
      );

  PriceRecordsByPeriodProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
    required this.period,
  }) : super.internal();

  final int productId;
  final PricePeriod period;

  @override
  Override overrideWith(
    FutureOr<List<PriceRecord>> Function(PriceRecordsByPeriodRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PriceRecordsByPeriodProvider._internal(
        (ref) => create(ref as PriceRecordsByPeriodRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
        period: period,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<PriceRecord>> createElement() {
    return _PriceRecordsByPeriodProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PriceRecordsByPeriodProvider &&
        other.productId == productId &&
        other.period == period;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);
    hash = _SystemHash.combine(hash, period.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PriceRecordsByPeriodRef
    on AutoDisposeFutureProviderRef<List<PriceRecord>> {
  /// The parameter `productId` of this provider.
  int get productId;

  /// The parameter `period` of this provider.
  PricePeriod get period;
}

class _PriceRecordsByPeriodProviderElement
    extends AutoDisposeFutureProviderElement<List<PriceRecord>>
    with PriceRecordsByPeriodRef {
  _PriceRecordsByPeriodProviderElement(super.provider);

  @override
  int get productId => (origin as PriceRecordsByPeriodProvider).productId;
  @override
  PricePeriod get period => (origin as PriceRecordsByPeriodProvider).period;
}

String _$priceNotifierHash() => r'293404b30e80a3d8ddf9cdb48775e27be6f30892';

/// 価格記録操作のNotifier
///
/// Copied from [PriceNotifier].
@ProviderFor(PriceNotifier)
final priceNotifierProvider =
    AutoDisposeAsyncNotifierProvider<PriceNotifier, void>.internal(
      PriceNotifier.new,
      name: r'priceNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$priceNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PriceNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
