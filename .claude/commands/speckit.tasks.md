計画書（plan.md）と仕様書（spec.md）からスライド作成タスクリストを生成します。

## 実行手順

1. **セットアップ**: フィーチャーブランチとドキュメントを確認する。
   ```bash
   .specify/scripts/bash/check-prerequisites.sh --json
   ```
   JSON 出力から `FEATURE_DIR` と利用可能なドキュメントのリストを取得する。

2. **設計書の読み込み**:
   - **必須**: `plan.md`（スライド構成・ファイル一覧）、`spec.md`（ゴール・章立て）
   - **任意**: `data-model.md`、`research.md`（存在する場合）

3. **タスクリストの生成**: `.specify/templates/tasks-template.md` の形式で `tasks.md` を生成する:

   **Phase 1: セットアップ**
   - 表紙画像（`images/title.svg`）のカスタマイズ
   - Mermaid 図ソースファイル（`images/src/*.mmd`）の作成

   **Phase 2: 基盤（共通要素）**
   - `00_intro.md`: 表紙・ゴールスライドの作成

   **Phase 3以降: 各セクション（spec.md の優先順位順）**
   - 各 `NN_name.md` ファイルのスライド作成（title-slide → 本文スライド群）

   **最終フェーズ: 仕上げ**
   - `timer/index.html` の AGENDA 更新
   - `03_summary.md` のまとめ・締めスライド確認

4. **タスクフォーマット**:
   ```
   - [ ] T001 presentation/00_intro.md の表紙スライドを作成する
   - [ ] T002 [P] images/src/architecture.mmd を編集して図を作成する
   - [ ] T003 [US1] presentation/01_section.md のtitle-slideを作成する
   ```

5. **完了報告**: `tasks.md` のパス・タスク総数・並列実行可能なタスク数を報告する。

## タスクフォーマット規約

- `- [ ] T001` 形式（チェックボックス + ID）
- `[P]` は並列実行可能なタスク
- `[US1]` 等はどのユーザーストーリー（章）に対応するか
- 各タスクには具体的なファイルパスを含める
