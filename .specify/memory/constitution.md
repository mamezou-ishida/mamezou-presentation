# Mamezou プレゼンテーション Constitution

## Core Principles

### I. Presentation Format
Marp Markdown形式でスライドを作成する。
クリーンでシンプルな構造を保ち、1スライドにつき1メッセージを徹底し、オンラインでも視認性の高いスライドを心がける。

### II. Visual Design & Theme
会社のデザインガイドラインに従い、豆蔵テーマ（`presentation/mamezou-theme.css`）を使用する。
- **ベースカラー:** 会社のイメージカラーである **薄い紫色（ライトパープル: `#EDE1F8`）** を背景色などのベーストーンとする
- **タイトルスライド:** 各章の表紙となるスライドは、**ダークパープル系のグラデーション**を背景色とし、リッチな印象を与える
- **アイキャッチスライド:** 通常のスライドとメリハリをつけて強調したいページには `highlight-slide` クラスを適用する
- **ロゴの配置:** 各スライド右上に会社ロゴ（`images/mamezo.png`）を固定で表示する。元が白色のロゴのため、通常スライドでは黒抜き（`filter: brightness(0)`）にして表示する
- **フッター要素:** フッターにはページ番号（スライド番号）のみを記載する

### III. Typography
オンラインの画面越しでも視認性の高い、可読性の高いサンセリフ体（ゴシック体）を採用する。
- **メインフォント:** `"BIZ UDPGothic"` をベースとし、フォールバックとしてシステムゴシック（`-apple-system` 等）を指定する
- **フォントサイズ:** 本文は `24pt` 程度を基本としつつ、文字量が多い場面では最低 `20pt` までの縮小を許容する
- **行間 / 余白:** 十分な余白をとり、スライド1枚に詰め込みすぎない

### IV. Slide Layout
Marpでのスライドデザインでは、テーマCSSファイル `presentation/mamezou-theme.css` に定義するユーティリティクラスを活用する。

- **`.title-slide`**: 各章の扉スライド（ダークパープルグラデーション背景、`<!-- class: title-slide -->`）
- **`.cover-slide`**: 表紙スライド（背景画像を使用、ロゴ非表示）
- **`.highlight-slide`**: アイキャッチ・強調スライド（`<!-- _class: highlight-slide -->`）
- **`.two-columns`**: 左右2カラムレイアウト
- **`.small-list`**: フォントサイズを縮小した箇条書き（情報量が多い場合）
- **`.rounded-image`**: 角丸画像表示
- **`.center-image`**: 中央寄せ・60%幅の画像表示
- **`.large-image`**: 横幅いっぱいの大きな画像表示
- **`.Label`**: バッジ/タグ表示（カテゴリ分類など）

### V. Writing Style
- スライド本文の口調は **「だ・である」調（常体）** で統一する
- ただし、導入パートは聴衆への語りかけとなるため **「です・ます」調（敬体）** を使用してもよい
- 引用部分は原文を尊重し、口調の統一対象外とする
- 強調には鉤括弧（「」）を避け、HTMLの `<strong>` タグを使用する（Markdown の `**` は不使用）

### VI. File Structure
- スライドは `presentation/` に `NN_name.md` 形式で番号付きで配置する
- `00_intro.md` を表紙・ゴール提示に使用し、以降のファイルをセクション別に管理する
- 図のソースコード（Mermaid等）は `images/src/` に配置し、生成画像は `images/` に配置する
- GitHub Actions が `main` ブランチへのプッシュ時に HTML/PDF を自動ビルドし、GitHub Pages にデプロイする

## Workflow
- スライドの構成・原稿はまずMarkdownのテキストとして作成・推敲する
- テーマCSSファイルは `presentation/mamezou-theme.css` に定義する
- デザインの調整はVS Code の Marp プレビューで確認しながら進める
- AIによる生成後は必ず人間がレビューし、内容に責任を持つ
- Mermaid等の図は `images/src/` にソースコードを、`images/` に生成画像をそれぞれ管理する

**Version**: 1.0.0 | **Ratified**: [YYYY-MM-DD（本リポジトリ使用開始日に更新）]
