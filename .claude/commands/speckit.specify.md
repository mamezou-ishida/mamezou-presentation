プレゼンテーションの仕様を作成・更新します。

## 入力

ユーザーが `/speckit.specify` の後に入力したテキストがプレゼンテーションの説明です。

## 実行手順

1. **ブランチ名の生成**: プレゼンテーションの説明から 2〜4 単語の英語ブランチ名を生成する（例: "scrum-ai-utilization"）

2. **既存ブランチの確認**:
   ```bash
   git fetch --all --prune
   git branch -a | grep -E '[0-9]+-'
   ls specs/ 2>/dev/null
   ```
   最大番号 N を確認し、新しいブランチ番号は N+1 とする。

3. **ブランチとディレクトリの作成**:
   ```bash
   .specify/scripts/bash/create-new-feature.sh --json --number <N+1> --short-name "<short-name>" "<説明>"
   ```
   スクリプトの JSON 出力から `BRANCH_NAME` と `SPEC_FILE` のパスを取得する。

4. **テンプレートの読み込み**: `.specify/templates/spec-template.md` を読んで必要なセクションを確認する。

5. **仕様書の作成**: `.specify/memory/constitution.md` を参照しながら、以下の内容で仕様書を作成する:
   - プレゼンテーションのゴール・対象者
   - 章立て・構成案
   - 各スライドで伝えたいメッセージ
   - 使用するレイアウト・図の概要
   - 成功基準（聴衆に何が伝われば成功か）

6. **品質チェック**: 仕様が具体的・測定可能・テーマの規約に沿っているか確認する。不明点は最大3つまでユーザーに質問する。

7. **完了報告**: ブランチ名・仕様書パスを報告し、次のステップ（`/speckit.plan`）へ誘導する。

## 規約

- `.specify/memory/constitution.md` の規約に従う
- 仕様は実装（HTML/CSS）の詳細ではなく「何を伝えるか」に集中する
- 章立ては `presentation/NN_name.md` のファイル構成と対応させる
