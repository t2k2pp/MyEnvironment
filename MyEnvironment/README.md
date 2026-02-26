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

## 🚀 使い方 (Zero-config Orchestration)

この環境は、**「メインのAIエージェント（あなた）はコーダーではなく、プロジェクトマネージャー（PM）として全体を指揮し、実作業はサブエージェントに委譲する」** という最新の Agentic Coding アーキテクチャに基づいています。

### 1. プロジェクトを開くだけで自動セットアップ
プロジェクト直下にある `.cursorrules`（エディタ連携用絶対ルール）により、Antigravity や Claude Code 等のAIエージェントでこのフォルダを開き、プロンプトを送信した時点で「自分がPMである」という自覚と基本ルールが自動で読み込まれます。

### 2. 環境構築は「サブエージェント」に任せる
新しいタスクに着手する際、メインエージェントは自ら `catalog.yaml` を読んだりしません。別プロセスとして `templates/subagents/context-manager.md` を呼び出します。
- サブエージェントが現在のフェーズ・言語に必要なファイルリストだけを分析して返します。
- メインエージェントは送られてきた軽量なリストだけをコンテキスト（メモリ）に取り込みます。
*(これにより、思考限界の突破と劇的なトークンコスト削減を実現します)*

### 3. 実装・検証も「専門家」に任せる
- 設計が必要なら `architect.md` サブエージェントを召喚。
- 実装・テストなら `tdd-guide.md` や各言語特化スキルに従ってAI実装者に委譲。
- PR前には `verify.md` ワークフローに従い、テスト・Lint・シークレットチェックを自動実行します。

### 4. （オプショナル）プロンプトロガーの設定
UserPromptSubmit時にプロンプトを記録させる場合は、各CLIの設定を利用して以下のスクリプトをHookに登録してください。
- **Windows**: `pwsh hooks/prompt_logger.ps1 "[ユーザーのプロンプト]"`
- **Mac/Linux**: `bash hooks/prompt_logger.sh "[ユーザーのプロンプト]"`

---

## 🔒 コントリビューション
ご自身で独自の「言語特化スキル (domains)」や「サブエージェント」を作成した場合、`catalog.yaml` に追記し、このリポジトリの `templates/` 以下に PR を行うか、コミットして更新してください。
これにより、他の環境（PC・OS）からもシームレスに `context-manager.md` 経由で呼び出すことが可能になります。
