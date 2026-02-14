import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/category/presentation/screens/category_list_screen.dart';
import '../../features/category/presentation/screens/category_form_screen.dart';
import '../../features/product/presentation/screens/product_list_screen.dart';
import '../../features/product/presentation/screens/product_detail_screen.dart';
import '../../features/product/presentation/screens/product_form_screen.dart';
import '../../features/price/presentation/screens/price_form_screen.dart';
import '../../features/store/presentation/screens/store_list_screen.dart';
import '../../features/store/presentation/screens/store_form_screen.dart';

/// アプリケーションのルーティング設定
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    // ホーム画面（カテゴリ一覧）
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const CategoryListScreen(),
    ),
    
    // カテゴリ追加
    GoRoute(
      path: '/category/add',
      name: 'categoryAdd',
      builder: (context, state) => const CategoryFormScreen(),
    ),
    
    // カテゴリ編集
    GoRoute(
      path: '/category/:id/edit',
      name: 'categoryEdit',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return CategoryFormScreen(categoryId: id);
      },
    ),
    
    // 商品一覧（カテゴリ別）
    GoRoute(
      path: '/category/:categoryId/products',
      name: 'productList',
      builder: (context, state) {
        final categoryId = int.parse(state.pathParameters['categoryId']!);
        return ProductListScreen(categoryId: categoryId);
      },
    ),
    
    // 商品追加
    GoRoute(
      path: '/category/:categoryId/products/add',
      name: 'productAdd',
      builder: (context, state) {
        final categoryId = int.parse(state.pathParameters['categoryId']!);
        return ProductFormScreen(categoryId: categoryId);
      },
    ),
    
    // 商品詳細（価格履歴含む）
    GoRoute(
      path: '/product/:id',
      name: 'productDetail',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return ProductDetailScreen(productId: id);
      },
    ),
    
    // 商品編集
    GoRoute(
      path: '/product/:id/edit',
      name: 'productEdit',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return ProductFormScreen(productId: id);
      },
    ),
    
    // 価格記録追加
    GoRoute(
      path: '/product/:productId/price/add',
      name: 'priceAdd',
      builder: (context, state) {
        final productId = int.parse(state.pathParameters['productId']!);
        return PriceFormScreen(productId: productId);
      },
    ),
    
    // 店舗一覧
    GoRoute(
      path: '/stores',
      name: 'storeList',
      builder: (context, state) => const StoreListScreen(),
    ),
    
    // 店舗追加
    GoRoute(
      path: '/stores/add',
      name: 'storeAdd',
      builder: (context, state) => const StoreFormScreen(),
    ),
    
    // 店舗編集
    GoRoute(
      path: '/stores/:id/edit',
      name: 'storeEdit',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return StoreFormScreen(storeId: id);
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('エラー')),
    body: Center(
      child: Text('ページが見つかりません: ${state.uri}'),
    ),
  ),
);
