import 'package:drift/drift.dart';

/// カテゴリテーブル
/// 商品を分類するためのカテゴリを管理
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 商品テーブル
/// カテゴリに属する個別の商品を管理
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer().references(Categories, #id)();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get memo => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 店舗テーブル
/// 購入店舗情報を管理（再利用可能）
class Stores extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get address => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 価格記録テーブル
/// 商品ごとの価格履歴を管理
class PriceRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get storeId => integer().references(Stores, #id)();
  IntColumn get price => integer()();
  DateTimeColumn get purchaseDate => dateTime()();
  TextColumn get memo => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 商品画像テーブル
/// 商品に紐づく写真を管理（オプション機能）
class ProductImages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id)();
  TextColumn get imagePath => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
