# MyEnvironment: Agentic Coding Templates & Tools

このリポジトリは、Antigravity、Claude Code、Gemini CLI などの AI エージェント（LLMエージェント）を使用した開発「Agentic Coding」の効率と品質を最大化するためのテンプレート、スキル、フックスクリプトの統合環境です。

## 💪 主な提供機能

1. **プロンプト保存フック**: ユーザーが入力したプロンプトを自動的に記録し、履歴をJSONLで保存。
2. **コンテキスト・マネージャー**: 作業フェーズ・開発言語に応じてエージェントのコンテキスト（読み込みファイル）を動的にON/OFFし、LLMのコスト削減と精度向上を実現。
3. **ルール & สキル群**: Flutter、React (Node.js)、Python など、言語特化のベストプラクティスとTDD（テスト駆動開発）を強制。
4. **サブエージェント**: アーキテクト、プランナー、セキュリティレビュアー等、フェーズごとの専門家プロンプト。
5. **汎用カタログ**: `catalog.yaml` によるツール・定義の一覧化と一元管理。

---

## 📁 ディレクトリ構造

```text
MyEnvironment/
├── catalog.yaml                  # 全スキル・エージェントを分類したインデックス
├── hooks/                        # エージェントフック用スクリプト
│   ├── prompt_logger.ps1         # Windows環境用 プロンプトロガー
│   └── prompt_logger.sh          # Mac/Linux環境用 プロンプトロガー
│
├── templates/                    # コピーしてプロジェクトに配置する定義テンプレート
│   ├── rules/                    # 初期設定ルール (.cursorrules 等のベース)
│   │   ├── rules_template.md     # プロジェクトベースルール
│   │   └── spec_driven_development.md  # 設計駆動開発のルール
│   │
│   ├── skills/                   # 特定のタスク手順やドメイン知識
│   │   ├── SKILL_TEMPLATE.md     # 新規スキル作成のひな形
│   │   ├── steering_template.md  # タスク進捗 (task.md) 強制管理スキル
│   │   ├── context-manager.md    # [最重要] フェーズベースの動的コンテキスト管理スキル
│   │   └── domains/              # 言語・フレームワーク特化の設計/実装スキル
│   │       ├── flutter-development.md
│   │       ├── node-react-development.md
│   │       └── python-development.md
│   │
│   ├── subagents/                # 役割ごとの専用エージェントプロンプト
│   │   ├── subagent_template.yaml
│   │   ├── architect.md          # 複雑なシステム設計・技術選定対応
│   │   ├── planner.md            # 実装前のタスク・フェーズ立案
│   │   ├── security-reviewer.md  # 脆弱性およびシークレットの監査
│   │   ├── tdd-guide.md          # TDDとカバレッジの強制
│   │   ├── doc-reviewer.md       # ドキュメントの品質および一貫性レビュー
│   │   └── implementation-validator.md # 実装されたコードの仕様（Spec）準拠の検証
│   │
│   └── workflows/                # 複合ステップの実行フロー
│       ├── add-feature.md        # 設計→実装→テストの完全自動フロー
│       └── verify.md             # PR前の統合検証（ビルド/Lint/テスト/監査）
```

---

## 🚀 使い方 (Getting Started)

### 1. プロンプトロガー (Hooks) の設定
Antigravity や Claude Code でユーザーコマンドをインターセプトするタイミング (例: `UserPromptSubmit` 等のライフサイクルイベント) で、以下のスクリプトを呼び出す設定をエージェントCLIに行います。
- **Windows**: `pwsh hooks/prompt_logger.ps1 "[ユーザーのプロンプト]"`
- **Mac/Linux**: `bash hooks/prompt_logger.sh "[ユーザーのプロンプト]"`
※ 記録されたログファイルはデフォルトで `~/.agent_prompts.jsonl` に保存されます。

### 2. コンテキスト・マネージャーの起動 (Context Management)
最も重要な運用手法です。エージェントを新規プロジェクトで立ち上げる際や、別の作業（例: 設計フェーズから実装フェーズ）に移る際、エージェントに対して「コンテキスト・マネージャーを起動して」と指示してください。

```text
// ユーザーからの指示例:
「catalog.yaml に記載されている templates/skills/context-manager.md を読んで、
現在のターゲット（Flutter）とフェーズ（Implementation）に合わせて、
必要なスキルやエージェントだけをロード（ON）し、不要なものをアンロード（OFF）して下さい。」
```
エージェントは自ら `catalog.yaml` と照らし合わせ、その瞬間に必要なファイル（例: `flutter-development.md` と `tdd-guide.md` のみ）を読み込み、不要な `architect.md` 等を思考ログから削除し、メモリ空間を最大限に効率化します。

### 3. 各種テンプレートの活用
自身のプロジェクトのルートディレクトリ等にコピーして使うことができます。

- プロジェクト立ち上げ時:
  - `templates/rules/spec_driven_development.md` などを `.claude/rules/` 等にコピー
- PR作成前:
  - 全てのテストと静的解析を回すために、「`templates/workflows/verify.md` に従って検証を実施して」と指示を出します。

---

## 🔒 コントリビューション
ご自身で独自の「言語特化スキル (domains)」や「サブエージェント」を作成した場合、`catalog.yaml` に追記し、このリポジトリの `templates/` 以下に PR を行うか、コミットして更新してください。
これにより、他の環境（PC・OS）からもシームレスに `context-manager.md` 経由で呼び出すことが可能になります。
