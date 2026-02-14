// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$storesStreamHash() => r'535ab65a742de0fbaac32139d4b59c5b99c7afa9';

/// 店舗一覧をストリームで監視
///
/// Copied from [storesStream].
@ProviderFor(storesStream)
final storesStreamProvider = AutoDisposeStreamProvider<List<Store>>.internal(
  storesStream,
  name: r'storesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$storesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StoresStreamRef = AutoDisposeStreamProviderRef<List<Store>>;
String _$storeNotifierHash() => r'1a726f39241d7bc39726539dff745578fdd86f1f';

/// 店舗操作のNotifier
///
/// Copied from [StoreNotifier].
@ProviderFor(StoreNotifier)
final storeNotifierProvider =
    AutoDisposeAsyncNotifierProvider<StoreNotifier, void>.internal(
      StoreNotifier.new,
      name: r'storeNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$storeNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$StoreNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
