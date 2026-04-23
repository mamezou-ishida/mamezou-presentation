# Mamezou Presentation Template — Claude Code Guide

## プロジェクト概要

このリポジトリは豆蔵社員向けの **Marp プレゼンテーション テンプレート**です。  
Markdown でスライドを作成し、GitHub Actions で自動的に HTML/PDF を生成して GitHub Pages に公開します。

## ディレクトリ構造

```
presentation/        # スライドファイル（NN_name.md 形式）
  00_intro.md        # 表紙・ゴール提示
  01_section.md      # 第1セクション（レイアウト例を含む）
  02_section.md      # 第2セクション（Mermaid 図の例）
  03_summary.md      # まとめ・締めスライド
  mamezou-theme.css  # 豆蔵ブランドのMarpテーマ
images/
  mamezo.png         # 会社ロゴ（テーマCSSがヘッダーに自動配置）
  title.svg          # サンプル表紙画像（差し替えてください）
  src/               # Mermaid 等の図のソースファイル（.mmd）
.specify/memory/constitution.md  # プレゼンテーション作成規約
timer/index.html     # 発表タイマーアプリ（AGENDA を編集して使用）
```

## スライドの編集方法

1. `presentation/` 内の Markdown ファイルを編集する
2. VS Code + [Marp for VS Code](https://marketplace.visualstudio.com/items?itemName=marp-team.marp-vscode) でリアルタイムプレビューが可能
3. `main` ブランチに push すると GitHub Actions が自動ビルドして GitHub Pages に公開

## テーマのCSSクラス

| クラス | 用途 |
|---|---|
| `title-slide` | 章の扉スライド（ダークパープル背景） |
| `cover-slide` | 表紙（背景画像使用、ロゴ非表示） |
| `highlight-slide` | アイキャッチ・強調スライド |
| `two-columns` | 左右2カラムレイアウト |
| `small-list` | フォント縮小の箇条書き |
| `rounded-image` | 角丸画像 |
| `center-image` | 中央寄せ・60%幅画像 |
| `large-image` | 横幅いっぱいの大画像 |
| `Label` | バッジ/タグ表示 |

## 利用可能な Claude Code スラッシュコマンド

このプロジェクトでは以下のスラッシュコマンドが使えます:

- `/speckit.specify` — スライドの仕様・構成を作成する
- `/speckit.plan` — 実装計画（スライドの詳細構成）を作成する
- `/speckit.tasks` — タスクリストを生成する

### 推奨ワークフロー

1. `/speckit.specify プレゼンテーションの説明` でスライド仕様を作成
2. `/speckit.plan` で章立て・詳細構成を設計
3. `/speckit.tasks` でスライド作成タスクを生成
4. 各タスクを実行してスライドを作成
5. `main` に push して公開

## 作成規約

詳細は `.specify/memory/constitution.md` を参照してください。  
主要なルール:
- 1スライド1メッセージ
- 強調には `<strong>` タグを使用（`**` は不使用）
- スライド本文は「だ・である」調で統一
- 図のソースは `images/src/` で管理
