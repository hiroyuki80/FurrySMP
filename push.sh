#!/bin/bash

set -e

# ブランチ名取得（main/masterどちらでも対応）
BRANCH=$(git branch --show-current)

# コミットメッセージ
if [ $# -gt 0 ]; then
    MSG="$*"
else
    MSG="Update $(date '+%Y-%m-%d %H:%M:%S')"
fi

git add .

# 変更がなければ終了
if git diff --cached --quiet; then
    echo "変更はありません。"
    exit 0
fi

git commit -m "$MSG"
git push origin "$BRANCH"

echo "✅ Push 完了！"