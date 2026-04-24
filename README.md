# mamezou-presentation

豆蔵社員向けの **Marp + AI プレゼンテーション テンプレート**です。  
[MIT ライセンス](./LICENSE) のもと、**社外の方も自由に改変・再利用**できます。  
Markdown でスライドを作成し、GitHub Actions で自動的に HTML/PDF を生成して GitHub Pages に公開できます。

## 特徴

- **豆蔵ブランドテーマ**: 紫系カラーの企業ロゴ入りスライドテーマ（`mamezou-theme.css`）
- **自動ビルド・公開**: `main` ブランチへの push で HTML/PDF が自動生成され GitHub Pages に公開
- **Mermaid 図対応**: `.mmd` ファイルから図を自動生成
- **AI 支援ワークフロー**: [GitHub Spec Kit](https://github.com/github/spec-kit) を使った仕様駆動のスライド作成を Gemini CLI・Claude Code でサポート
- **発表タイマー**: AGENDA 編集可能なカウントダウンタイマーアプリ同梱

---

## テンプレートのデモ（プレビュー）

このテンプレートリポジトリ自体のビルド結果を以下から確認できます:

| 種類 | リンク |
|---|---|
| HTML スライド | https://mamezou-ishida.github.io/mamezou-presentation/ |
| PDF | https://mamezou-ishida.github.io/mamezou-presentation/slide.pdf |
| タイマーアプリ | https://mamezou-ishida.github.io/mamezou-presentation/timer/ |

> 自分のリポジトリで公開した場合は `https://<your-org>.github.io/<your-repo>/` に置き換えてください。

---

## 前提条件

| ツール | 用途 |
|---|---|
| [VS Code](https://code.visualstudio.com/) + [Marp for VS Code](https://marketplace.visualstudio.com/items?itemName=marp-team.marp-vscode) | スライドのリアルタイムプレビュー |
| Git + GitHub アカウント | バージョン管理・公開 |
| [Gemini CLI](https://github.com/google-gemini/gemini-cli) （任意） | AI 支援ワークフロー（Gemini 版） |
| [Claude Code](https://claude.ai/code) （任意） | AI 支援ワークフロー（Claude 版） |

---

## クイックスタート

### Step 1: テンプレートからリポジトリを作成

1. このページ上部の **「Use this template」** ボタンをクリック
2. **「Create a new repository」** を選択
3. リポジトリ名・可視性を設定して **「Create repository from template」**

### Step 2: GitHub Pages を有効化

1. 作成したリポジトリの **Settings** → **Pages** を開く
2. **Build and deployment** → Source: **「GitHub Actions」** を選択して保存

### Step 3: リポジトリを clone

```bash
git clone https://github.com/<your-org>/<your-repo>.git
cd <your-repo>
```

### Step 4: スライドを編集

```
presentation/
  00_intro.md      # 表紙・ゴールスライドを編集
  01_section.md    # 第1セクションを編集（不要なら削除）
  02_section.md    # 第2セクションを編集（不要なら削除）
  03_summary.md    # まとめ・締めスライドを編集
```

VS Code で Markdown ファイルを開き、コマンドパレット（Windows/Linux: `Ctrl+Shift+P` / Mac: `Cmd+Shift+P`）を開いて **「Marp: Open Preview to the Side」** を選択するとプレビューできます。

### Step 5: push して公開

```bash
git add .
git commit -m "プレゼンテーションの内容を追加"
git push origin main
```

GitHub Actions が自動でビルドし、`https://<your-org>.github.io/<your-repo>/` に公開されます。

---

## スライドの構成と編集方法

### ファイル命名規則

`presentation/NN_name.md`（`NN` は2桁の数字）で番号順に結合されます。

| ファイル | 役割 |
|---|---|
| `00_intro.md` | 表紙 + ゴール提示（必須） |
| `01_section.md` | 第1セクション |
| `02_section.md` | 第2セクション |
| `03_summary.md` | まとめ・締め（必須） |

セクションを追加したい場合は `04_new_section.md` のように数字を追加するだけです。

### 表紙画像のカスタマイズ

`images/title.svg` を差し替えて表紙をカスタマイズしてください。  
SVG はテキストファイルなので、VS Code でそのまま開いて編集できます。

**`images/title.svg` のテキストを編集する場合**、以下の `<text>` 要素を書き換えてください:

```xml
<!-- メインタイトル（2行） -->
<text ...>プレゼンテーションタイトル</text>

<!-- サブタイトル -->
<text ...>サブタイトル（任意）</text>

<!-- 発表者・イベント情報 -->
<text ...>発表者名｜YYYY年MM月　イベント名</text>
```

> 背景グラデーションの色は `#2b1a4a`（濃い紫）→ `#6e40c9`（明るい紫）です。変更する場合は `<stop>` 要素の `stop-color` を編集してください。  
> 別のツール（Figma・Canva・PowerPoint 等）で作成した 1280×720px の PNG/SVG に差し替えることもできます。

### フロントマターの書き方

各 `NN_*.md` ファイル（`00_intro.md` 以外）の先頭フロントマターは以下の形式で書いてください:

```markdown
---
marp: true
theme: mamezou-theme
header: " "
---
<!-- class: title-slide -->

## 第1部
# セクションタイトル
```

---

## テーマのCSSクラス一覧

スライドの `<!-- class: クラス名 -->` または `<!-- _class: クラス名 -->` で指定します。

| クラス | 説明 | 使い方 |
|---|---|---|
| `title-slide` | 章の扉スライド（ダークパープル背景・白文字） | `<!-- class: title-slide -->` |
| `cover-slide` | 表紙スライド（背景画像使用、ロゴ非表示） | `<!-- class: cover-slide -->` |
| `highlight-slide` | アイキャッチ・強調スライド | `<!-- _class: highlight-slide -->` |
| `two-columns` | 左右2カラムレイアウト | `<div class="two-columns">` |
| `small-list` | フォント縮小の箇条書き | `<div class="small-list">` |
| `rounded-image` | 角丸画像 | `<div class="rounded-image">` |
| `center-image` | 中央寄せ・60%幅画像 | `<div class="center-image">` |
| `large-image` | 横幅いっぱいの大画像 | `<div class="large-image">` |
| `Label` | バッジ/タグ | `<span class="Label">テキスト</span>` |

> 具体的な使用例は `presentation/01_section.md` を参照してください。

---

## AI 支援ワークフロー

[GitHub Spec Kit](https://github.com/github/spec-kit) は「仕様 → 計画 → タスク → 実装」という段階的なワークフローを AI と協調して進めるための仕組みです。このテンプレートでは Gemini CLI および Claude Code のスラッシュコマンドとして組み込まれており、プレゼンテーションの構成設計から個別スライドの作成まで AI に補助させることができます。

### 前提: ツールのインストール

| ツール | インストール方法 |
|---|---|
| [Gemini CLI](https://github.com/google-gemini/gemini-cli) | `npm install -g @google/gemini-cli` |
| [Claude Code](https://claude.ai/code) | `npm install -g @anthropic-ai/claude-code` |

どちらか一方で構いません。コマンド体系は同一です。

### ワークフロー全体像

```
/speckit.specify  →  /speckit.plan  →  /speckit.tasks  →  スライド作成  →  push
     ↓                    ↓                  ↓
  specs/NNN-*/          plan.md           tasks.md
   spec.md
```

各コマンドは **フィーチャーブランチ**（`NNN-short-name` 形式）上で実行します。  
`/speckit.specify` が自動的にブランチを作成するので、最初に実行するだけで準備が整います。

---

### Step 1: 仕様の作成 `/speckit.specify`

プレゼンテーションの内容を自然言語で伝えると、AI がブランチを作成して仕様書（`spec.md`）を生成します。

```
/speckit.specify スクラムマスターのAI活用について30分で発表する。
対象は社内のエンジニア。透明性・検査・適応の3つの観点で実践例を紹介したい。
```

**実行後に生成されるもの:**
- フィーチャーブランチ（例: `001-scrum-ai-utilization`）
- `specs/001-scrum-ai-utilization/spec.md`（発表ゴール・章立て案・成功基準）
- `specs/001-scrum-ai-utilization/checklists/requirements.md`（品質チェックリスト）

不明点がある場合、AI から最大3つの確認質問が来ます。回答すると仕様書が確定します。

---

### Step 2: 実装計画の作成 `/speckit.plan`

仕様書をもとに、スライドファイルの構成・各スライドのレイアウト・図の配置計画を設計します。

```
/speckit.plan
```

**実行後に生成されるもの:**
- `specs/001-xxx/plan.md`（スライドファイル一覧・各スライドの構成詳細）
- `specs/001-xxx/research.md`（参照情報・設計上の判断メモ）

---

### Step 3: タスクリストの生成 `/speckit.tasks`

計画書からスライド作成のタスクリストを生成します。依存関係と優先順位が整理された状態で出力されます。

```
/speckit.tasks
```

**実行後に生成されるもの:**
- `specs/001-xxx/tasks.md`（実行順に並んだタスク一覧）

例:
```
- [ ] T001 images/title.svg のタイトルテキストを書き換える
- [ ] T002 presentation/00_intro.md の発表ゴールを記述する
- [ ] T003 [P] images/src/architecture.mmd を作成する
- [ ] T004 [US1] presentation/01_section.md の title-slide を作成する
...
```

`[P]` は並列実行可能なタスク、`[US1]` はどのセクションに対応するかを示します。

---

### Step 4: スライドの作成

タスクリストをもとに AI とともにスライドを作成していきます。  
各 Markdown ファイルを編集しながら、VS Code の Marp プレビューで確認します。

**（Gemini CLI のみ）整合性チェック:**

```
/speckit.analyze
```

仕様・計画・実装の三者間の整合性を検査し、抜け漏れや矛盾を報告します。

---

### Step 5: push して公開

```bash
git add .
git commit -m "プレゼンテーション完成"
git push origin main
```

`main` ブランチへのマージ・push で GitHub Actions が自動ビルドし、GitHub Pages に公開されます。

---

### 利用可能なコマンド一覧

| コマンド | 対応ツール | 説明 |
|---|---|---|
| `/speckit.specify` | Gemini / Claude | 仕様書の作成・更新 |
| `/speckit.plan` | Gemini / Claude | 実装計画の作成 |
| `/speckit.tasks` | Gemini / Claude | タスクリストの生成 |
| `/speckit.clarify` | Gemini のみ | 仕様の曖昧な点を整理・明確化 |
| `/speckit.checklist` | Gemini のみ | 品質チェックリストの生成 |
| `/speckit.implement` | Gemini のみ | 実装フェーズの実行 |
| `/speckit.analyze` | Gemini のみ | 仕様・計画・実装の整合性チェック |
| `/speckit.constitution` | Gemini のみ | プレゼンテーション規約の作成・更新 |
| `/speckit.taskstoissues` | Gemini のみ | タスクを GitHub Issues に変換 |

スライド作成規約の詳細は `.specify/memory/constitution.md` を参照してください。

---

## HTML スライドの操作方法

GitHub Pages で公開された HTML スライド（`index.html`）はブラウザ上でそのまま操作できます。

### キーボードショートカット

| キー | 動作 |
|---|---|
| `→` / `Space` / `PageDown` | 次のスライドへ |
| `←` / `PageUp` | 前のスライドへ |
| `f` | フルスクリーン切り替え |
| `p` | **プレゼンターモード**（話者ノート表示） |

### プレゼンターモードの使い方

`p` キーを押すと、ノート（発表者用）ウィンドウが別タブで開きます。

1. **メインウィンドウ**をプロジェクター・外部モニターに表示する
2. **ノートウィンドウ**を手元のPCに表示する
3. どちらで操作しても両方が同期してスライドが進む

> スライド内の `<!-- 話者ノート -->` コメントがノートウィンドウに表示されます。

---

## タイマーアプリの使い方

`timer/index.html` を GitHub Pages から開くか、ブラウザで直接開いて使用します。  
`https://<your-org>.github.io/<your-repo>/timer/`

発表前に `timer/index.html` 内の以下を編集してください:

```javascript
// 全体の発表時間を変更
const TOTAL_MINUTES = 30;

// アジェンダを発表内容に合わせて編集
const AGENDA = [
  { startMin:  0, endMin:  5, title: "オープニング・自己紹介" },
  { startMin:  5, endMin: 20, title: "第1部：タイトルを入力" },
  { startMin: 20, endMin: 28, title: "まとめ" },
  { startMin: 28, endMin: 30, title: "質疑応答 (Q&A)" }
];
```

---

## CI/CD の仕組み

`.github/workflows/deploy.yml` が `main` ブランチへの push をトリガーに以下を実行します:

1. 日本語フォント（Noto CJK）をインストール
2. `images/src/*.mmd` が存在する場合、Mermaid 図を PNG に変換
3. `presentation/NN_*.md` を数字順に結合して `combined.md` を生成
4. Marp CLI で HTML・PDF を生成
5. GitHub Pages にデプロイ

### Mermaid 図の作成

`images/src/` に `.mmd` ファイルを置くと、GitHub Actions が自動で PNG に変換します。

```bash
# ローカルで生成する場合
npx -y @mermaid-js/mermaid-cli -i images/src/architecture.mmd -o images/architecture.png -b transparent -s 3
```

スライドからは `![](../images/architecture.png)` で参照します。

### speckit 更新の自動チェック

`.github/workflows/check-speckit-updates.yml` は `github/spec-kit` upstream の変更を毎週検知し、差分を適用した PR を自動作成します。

**デフォルトでは無効**です。有効にするには以下の手順で Repository variable を追加してください:

1. リポジトリの **Settings** → **Secrets and variables** → **Actions** を開く
2. **Variables** タブ → **Repository variables** の **「New repository variable」** をクリック
3. 以下の値を入力して **「Add variable」** で保存

| フィールド | 入力値 |
|---|---|
| Name | `SPECKIT_AUTO_CHECK` |
| Value | `true` |

> `workflow_dispatch` による手動実行は変数設定なしでも常に使えます。

---

## ディレクトリ構造

```
.
├── CLAUDE.md                    # Claude Code 用ガイド
├── README.md                    # このファイル
├── .claude/commands/            # Claude Code スラッシュコマンド
├── .gemini/commands/            # Gemini CLI スラッシュコマンド（speckit）
├── .github/workflows/deploy.yml # GitHub Actions ワークフロー
├── .specify/                    # AI ワークフロー用テンプレート・スクリプト
│   ├── memory/constitution.md   # プレゼンテーション作成規約
│   ├── scripts/bash/            # speckit スクリプト
│   └── templates/               # 仕様書・計画書テンプレート
├── .vscode/settings.json        # Marp テーマ設定
├── images/
│   ├── mamezo.png               # 会社ロゴ
│   ├── title.svg                # サンプル表紙画像
│   └── src/architecture.mmd    # Mermaid 図のソース
├── presentation/
│   ├── mamezou-theme.css        # Marp テーマ CSS
│   ├── 00_intro.md              # 表紙・ゴール
│   ├── 01_section.md            # 第1セクション（レイアウト例）
│   ├── 02_section.md            # 第2セクション（Mermaid 図例）
│   └── 03_summary.md            # まとめ・締め
├── specs/                       # スペック管理（speckit が自動生成）
└── timer/index.html             # 発表タイマーアプリ
```

---

## GitHub テンプレートリポジトリの有効化（管理者向け）

このリポジトリを他の社員が「Use this template」で使えるようにするには:

1. リポジトリの **Settings** → **General** を開く
2. **Template repository** のチェックボックスにチェックを入れる
3. 保存する

---

## ライセンス

[MIT License](./LICENSE)

社内外を問わず、**自由に使用・改変・再配布**できます。著作権表示（`Copyright (c) 2026 mamezou-ishida`）をそのまま残すか、自分の情報に書き換えてご利用ください。

---

## ベースリポジトリ

このテンプレートは [mameyose202603](https://github.com/mamezou-ishida/mameyose202603) をベースに作成しています。
