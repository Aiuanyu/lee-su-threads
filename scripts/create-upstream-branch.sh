#!/bin/bash

# 建立專門用於貢獻上游个乾淨 branch
# Usage: bash scripts/create-upstream-branch.sh <branch-name>

set -e

# Get the script's directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$PROJECT_ROOT"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if branch name is provided
if [ -z "$1" ]; then
  echo -e "${RED}❌ 錯誤：請提供 branch 名稱${NC}"
  echo ""
  echo "用法："
  echo "  bash scripts/create-upstream-branch.sh <branch-name>"
  echo ""
  echo "範例："
  echo "  bash scripts/create-upstream-branch.sh fix-location-parser"
  echo "  bash scripts/create-upstream-branch.sh feature-add-city-support"
  exit 1
fi

BRANCH_NAME="$1"

# Check if upstream remote exists
if ! git remote | grep -q "^upstream$"; then
  echo -e "${YELLOW}⚠️  未發現 upstream remote，正在添加...${NC}"
  echo ""
  read -p "請輸入上游 repository URL (例如: https://github.com/meettomorrow/lee-su-threads.git): " UPSTREAM_URL

  if [ -z "$UPSTREAM_URL" ]; then
    echo -e "${RED}❌ 未提供 URL，終止操作${NC}"
    exit 1
  fi

  git remote add upstream "$UPSTREAM_URL"
  echo -e "${GREEN}✅ 已添加 upstream remote${NC}"
  echo ""
fi

echo -e "${BLUE}🔄 正在從上游同步最新變更...${NC}"
git fetch upstream

# Check if we're on a clean state
if ! git diff-index --quiet HEAD --; then
  echo -e "${RED}❌ 錯誤：目前工作目錄有未提交个變更${NC}"
  echo ""
  echo "請先提交或暫存你个變更："
  echo "  git stash          # 暫存變更"
  echo "  git commit -am \"message\"  # 提交變更"
  exit 1
fi

# Determine the main branch name (could be 'main' or 'master')
MAIN_BRANCH="main"
if git show-ref --verify --quiet refs/remotes/upstream/master; then
  MAIN_BRANCH="master"
fi

echo -e "${BLUE}📍 檢測到上游主分支：${MAIN_BRANCH}${NC}"

# Update local main/master branch
echo -e "${BLUE}🔄 更新本地 ${MAIN_BRANCH} 分支...${NC}"
git checkout "$MAIN_BRANCH"
git merge "upstream/${MAIN_BRANCH}" --ff-only

# Check if branch already exists
if git show-ref --verify --quiet "refs/heads/$BRANCH_NAME"; then
  echo -e "${RED}❌ 錯誤：Branch '$BRANCH_NAME' 已經存在${NC}"
  echo ""
  echo "請使用不同个名稱或刪除現有 branch："
  echo "  git branch -D $BRANCH_NAME"
  exit 1
fi

# Create new branch
echo -e "${BLUE}🌿 建立新 branch：$BRANCH_NAME${NC}"
git checkout -b "$BRANCH_NAME"

echo ""
echo -e "${GREEN}✅ 成功！${NC}"
echo ""
echo -e "${GREEN}📋 接下來个步驟：${NC}"
echo "  1. 進行你个程式碼變更"
echo "  2. 只提交功能相關个檔案 (避開 .github/workflows/claude*.yml)"
echo "  3. 檢查變更："
echo -e "     ${BLUE}git diff upstream/${MAIN_BRANCH}...${BRANCH_NAME} --name-only${NC}"
echo "  4. 確認無包含 fork-specific 檔案後，push 到你个 fork："
echo -e "     ${BLUE}git push origin ${BRANCH_NAME}${NC}"
echo "  5. 在 GitHub 上開 PR 到上游"
echo ""
echo -e "${YELLOW}⚠️  注意：${NC}"
echo "  - 毋好提交 .github/workflows/claude*.yml"
echo "  - 確保只包含愛貢獻个功能變更"
echo ""
