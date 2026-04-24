#!/usr/bin/env bash
# Compares local speckit commands/templates against upstream github/spec-kit.
#
# Usage:
#   ./update-speckit.sh              — 差分を表示するだけ
#   ./update-speckit.sh --apply      — 差分があるファイルを確認しながら適用
#   ./update-speckit.sh --apply --yes           — 全ファイルを自動適用（CI 用）
#   ./update-speckit.sh --apply --yes --no-color — 色なし出力（CI ログ・PR 本文用）

set -euo pipefail

UPSTREAM_REPO="https://github.com/github/spec-kit"
SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

APPLY=false
AUTO_YES=false
NO_COLOR=false

for arg in "$@"; do
    case "$arg" in
        --apply)    APPLY=true ;;
        --yes)      AUTO_YES=true ;;
        --no-color) NO_COLOR=true ;;
    esac
done

if [[ "$NO_COLOR" == true ]]; then
    RED='' GREEN='' YELLOW='' BOLD='' RESET=''
else
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BOLD='\033[1m'
    RESET='\033[0m'
fi

WORKDIR=$(mktemp -d)
trap 'rm -rf "$WORKDIR"' EXIT

# ── upstream を sparse clone ──────────────────────────────────────────────────
echo -e "${BOLD}upstream (github/spec-kit) を取得中...${RESET}"
git clone --depth 1 --filter=blob:none --sparse --quiet \
    "$UPSTREAM_REPO" "$WORKDIR/spec-kit"
(cd "$WORKDIR/spec-kit" && git sparse-checkout set templates 2>/dev/null)
UP="$WORKDIR/spec-kit/templates"
UPSTREAM_SHA=$(git -C "$WORKDIR/spec-kit" rev-parse HEAD)
echo ""

# ── 集計用 ───────────────────────────────────────────────────────────────────
UNCHANGED=0
CHANGED=0
# 差分があったファイルの情報を蓄積（bash 3.2 対応: インデックス配列で管理）
DIFF_LABELS=()
DIFF_LOCAL=()
DIFF_UPSTREAM=()
DIFF_MODES=()  # "toml" | "direct"

# TOML の prompt = """...""" ブロック内のテキストを取り出す
extract_prompt() {
    awk '/^prompt = """/{found=1; next} found && /^"""/{found=0} found{print}' "$1"
}

# TOML の prompt ブロック前のヘッダ行を取り出す
toml_header() {
    awk '/^prompt = """/{exit} {print}' "$1"
}

# 1ファイル分の比較を行い、差分があれば DIFF_* に追加する
check_file() {
    local label="$1"
    local local_file="$2"
    local upstream_file="$3"
    local mode="$4"  # "toml" | "direct"

    if [[ ! -f "$upstream_file" ]]; then
        printf "  ${YELLOW}?${RESET}  %s  ${YELLOW}(upstream に存在しない)${RESET}\n" "$label"
        return
    fi

    local local_content upstream_content
    upstream_content=$(cat "$upstream_file")
    if [[ "$mode" == "toml" ]]; then
        local_content=$(extract_prompt "$local_file")
    else
        local_content=$(cat "$local_file")
    fi

    if diff <(printf '%s\n' "$local_content") <(printf '%s\n' "$upstream_content") \
            > "$WORKDIR/diff_current" 2>/dev/null; then
        printf "  ${GREEN}✓${RESET}  %s\n" "$label"
        UNCHANGED=$((UNCHANGED + 1))
    else
        printf "  ${RED}✗${RESET}  %s\n" "$label"
        local n
        n=$(wc -l < "$WORKDIR/diff_current")
        head -40 "$WORKDIR/diff_current" | sed 's/^/      /'
        [[ $n -gt 40 ]] && echo "      ... (省略: $((n - 40)) 行)"
        CHANGED=$((CHANGED + 1))
        DIFF_LABELS+=("$label")
        DIFF_LOCAL+=("$local_file")
        DIFF_UPSTREAM+=("$upstream_file")
        DIFF_MODES+=("$mode")
    fi
}

# ── .gemini/commands/ の比較 ──────────────────────────────────────────────────
echo -e "${BOLD}── .gemini/commands/  (コマンドプロンプト)${RESET}"

# 「ローカルのTOMLステム」と「upstream の MD ファイル名」を対で列挙
CMD_PAIRS="
speckit.analyze:analyze
speckit.checklist:checklist
speckit.clarify:clarify
speckit.constitution:constitution
speckit.implement:implement
speckit.plan:plan
speckit.specify:specify
speckit.tasks:tasks
speckit.taskstoissues:taskstoissues
"

while IFS=: read -r stem upstream_name; do
    [[ -z "$stem" ]] && continue
    check_file \
        "${stem}.toml" \
        "$SCRIPT_DIR/.gemini/commands/${stem}.toml" \
        "$UP/commands/${upstream_name}.md" \
        "toml"
done <<< "$CMD_PAIRS"

# ── .specify/templates/ の比較 ────────────────────────────────────────────────
echo ""
echo -e "${BOLD}── .specify/templates/  (テンプレート)${RESET}"

TMPL_NAMES="spec-template plan-template tasks-template checklist-template constitution-template"

for name in $TMPL_NAMES; do
    check_file \
        "${name}.md" \
        "$SCRIPT_DIR/.specify/templates/${name}.md" \
        "$UP/${name}.md" \
        "direct"
done

# ── サマリー ─────────────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}結果: ${GREEN}${UNCHANGED} 件一致${RESET}  /  ${RED}${CHANGED} 件に差分あり${RESET}"

if [[ $CHANGED -eq 0 ]]; then
    echo "upstream と同期済みです。"
    exit 0
fi

if [[ "$APPLY" == false ]]; then
    echo ""
    echo -e "適用するには: ${BOLD}$(basename "$0") --apply${RESET}"
    exit 0
fi

# ── 適用 ─────────────────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}── 適用${RESET}"

i=0
while [[ $i -lt ${#DIFF_LABELS[@]} ]]; do
    label="${DIFF_LABELS[$i]}"
    local_file="${DIFF_LOCAL[$i]}"
    upstream_file="${DIFF_UPSTREAM[$i]}"
    mode="${DIFF_MODES[$i]}"

    if [[ "$AUTO_YES" == true ]]; then
        answer=y
        printf "  %s を更新します\n" "$label"
    else
        printf "  %s を更新しますか？ [y/N] " "$label"
        read -r answer
    fi

    if [[ ! "$answer" =~ ^[Yy]$ ]]; then
        i=$((i + 1))
        continue
    fi

    if [[ "$mode" == "toml" ]]; then
        # ヘッダ (description = "...") を残して prompt ブロックだけ差し替え
        {
            toml_header "$local_file"
            printf 'prompt = """\n'
            cat "$upstream_file"
            printf '\n"""\n'
        } > "$local_file.tmp" && mv "$local_file.tmp" "$local_file"
    else
        cp "$upstream_file" "$local_file"
    fi

    echo -e "    ${GREEN}更新しました${RESET}"
    i=$((i + 1))
done

# ── upstream SHA を記録 ───────────────────────────────────────────────────────
printf '%s\n' "$UPSTREAM_SHA" > "$SCRIPT_DIR/.specify/upstream-sha.txt"

echo ""
echo "完了。.specify/upstream-sha.txt を更新しました。変更を確認してからコミットしてください。"
