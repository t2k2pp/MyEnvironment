# 健康管理アプリ (Health Management App)

Android向け健康管理アプリケーション。Flutter + Riverpod 3.0で構築。

## 機能

- **📊 ダッシュボード** - 今日の健康データサマリー表示
- **✏️ データ入力** - 体重・体温・運動記録の入力
- **📈 グラフ表示** - 歩数・体重・体温の推移グラフ（期間選択可能）
- **🎯 目標設定** - 歩数・体重・運動時間の目標値設定
- **⚙️ 設定** - Health Connect連携、データ管理

## 技術スタック

| カテゴリ | 技術 |
|---------|------|
| フレームワーク | Flutter 3.x |
| 状態管理 | Riverpod 3.0 (riverpod_annotation) |
| ルーティング | go_router |
| ローカルDB | Drift (SQLite) |
| 健康データ連携 | health パッケージ (Health Connect) |
| グラフ | fl_chart |
| コード生成 | freezed, json_serializable |

## セットアップ

### 必要条件

- Flutter SDK 3.19+
- Dart 3.0+
- Android Studio / VS Code
- Android デバイス または エミュレータ（API 28+）

### インストール

```bash
# リポジトリをクローン
git clone https://github.com/t2k2pp/sdd_helthmobileapp.git
cd sdd_helthmobileapp

# パッケージをインストール
flutter pub get

# コード生成
dart run build_runner build --delete-conflicting-outputs

# アプリを実行
flutter run
```

## プロジェクト構成

```
lib/
├── core/                     # 共通コンポーネント
│   ├── constants/            # 定数
│   ├── database/             # Drift DB定義
│   ├── theme/                # テーマ設定
│   └── router.dart           # go_router設定
├── features/                 # 機能別モジュール
│   ├── dashboard/            # ダッシュボード画面
│   ├── health_data/          # 健康データ入力・グラフ
│   │   ├── data/             # データソース・リポジトリ
│   │   ├── domain/           # Entity定義
│   │   └── presentation/     # 画面・Provider
│   ├── goals/                # 目標設定
│   └── settings/             # 設定画面
└── main.dart                 # エントリポイント
```

## テスト

```bash
# すべてのテストを実行
flutter test

# カバレッジ付きで実行
flutter test --coverage
```

## Health Connect 連携

このアプリはAndroid Health Connect APIを使用して歩数データを自動取得します。

### 必要な権限

- `android.permission.health.READ_STEPS`
- `android.permission.health.READ_TOTAL_CALORIES_BURNED`
- `android.permission.health.READ_DISTANCE`
- `android.permission.ACTIVITY_RECOGNITION`

### 注意

- Health ConnectはAndroid 14以降で標準搭載
- Android 13以前の場合は[Google Play](https://play.google.com/store/apps/details?id=com.google.android.apps.healthdata)からインストールが必要
- エミュレータでは動作しない場合があります（実機推奨）

## ライセンス

MIT License

## 作者

t2k2pp
