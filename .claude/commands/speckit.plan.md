プレゼンテーションの実装計画（章立て・スライド詳細構成）を作成します。

## 実行手順

1. **セットアップ**: 現在のフィーチャーブランチを確認する。
   ```bash
   .specify/scripts/bash/setup-plan.sh --json
   ```
   JSON 出力から `FEATURE_SPEC`（仕様書パス）と `IMPL_PLAN`（計画書パス）を取得する。

2. **コンテキストの読み込み**:
   - `FEATURE_SPEC`（spec.md）を読む
   - `.specify/memory/constitution.md` を読む
   - `.specify/templates/plan-template.md` を読む

3. **計画書の作成**: テンプレートに従い以下を記述する:

   **Phase 0: 調査・整理**
   - 伝えたいメッセージの優先順位
   - 使用する図・データの洗い出し
   - 必要な画像・Mermaid 図のリスト

   **Phase 1: スライド構成設計**
   - 各 Markdown ファイル（`presentation/NN_name.md`）の役割と含めるスライド一覧
   - 各スライドのレイアウトクラス（title-slide, two-columns 等）
   - 図の配置とソースファイル（`images/src/*.mmd`）の計画

   **Phase 2: コンテンツ設計**
   - 各スライドのタイトルと主要メッセージ
   - 話者ノートの方針

4. **エージェントコンテキストの更新**:
   ```bash
   .specify/scripts/bash/update-agent-context.sh claude
   ```

5. **完了報告**: 計画書パス・スライドファイル一覧を報告し、`/speckit.tasks` へ誘導する。

## 規約

- constitution.md の Visual Design・Typography・Writing Style に準拠した計画にする
- 各 `presentation/NN_name.md` ファイルに対応するスライドをすべてリストアップする
- Mermaid 図が必要な場合は `images/src/` のファイル名まで決定する
