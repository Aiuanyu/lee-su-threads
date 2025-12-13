# Scripts 說明

這個目錄包含專案个自動化腳本。

## 可用个腳本

### 1. `create-upstream-branch.sh` - 建立上游貢獻分支

自動化建立乾淨个 branch 用於貢獻變更去上游 repository。

#### 使用方式

```bash
# 使用 npm script（推薦）
npm run upstream:branch <branch-name>

# 或直接執行腳本
bash scripts/create-upstream-branch.sh <branch-name>
```

#### 範例

```bash
npm run upstream:branch fix-location-parser
npm run upstream:branch feature-add-city-support
```

#### 功能

1. ✅ 檢查 `upstream` remote 係毋係存在（無存在會提示添加）
2. ✅ 從上游 fetch 最新變更
3. ✅ 更新本地 `main` 分支同上游同步
4. ✅ 從乾淨个 `main` 建立新 branch
5. ✅ 提供後續步驟个說明

#### 注意事項

- 執行前確保工作目錄係乾淨个（無未提交个變更）
- 建立个 branch 會從同步過上游个 `main` 開始
- 提交時注意避開 fork-specific 个檔案（如 `.github/workflows/claude*.yml`）

---

### 2. `package.sh` - 打包擴充功能

打包 Chrome 同 Firefox 擴充功能，準備上傳到商店。

#### 使用方式

```bash
bash scripts/package.sh
```

#### 功能

1. 建置擴充功能（`npm run build`）
2. 建立 `dist-zip/` 目錄
3. 打包 Chrome 版本（`.zip`）
4. 打包 Firefox AMO 版本（`.zip`）

#### 輸出

- `dist-zip/lee-su-threads-chrome-v{version}.zip` - Chrome Web Store 用
- `dist-zip/lee-su-threads-firefox-v{version}-amo.zip` - Firefox Add-ons 用

---

### 3. `run-firefox-android.sh` - 在 Android 上運行 Firefox

在連接个 Android 設備上運行 Firefox 擴充功能。

#### 使用方式

```bash
# 使用 npm script（推薦）
npm run start:firefox:android

# 或直接執行腳本
bash scripts/run-firefox-android.sh

# 指定設備 ID
npm run start:firefox:android <device-id>
```

#### 功能

1. 自動檢測連接个 Android 設備
2. 如果有多個設備，提供選擇介面
3. 在指定設備上啟動 Firefox 同擴充功能

#### 前置需求

- Android 設備透過 ADB 連接
- Firefox for Android 已安裝在設備上
- 已啟用 USB debugging

---

## 開發新腳本

當你添加新腳本時：

1. 確保腳本有執行權限：`chmod +x scripts/your-script.sh`
2. 在腳本開頭添加 `#!/bin/bash` 同 `set -e`
3. 使用顏色輸出來增強可讀性
4. 提供清楚个錯誤訊息
5. 更新這個 README 說明新腳本个用途

### 腳本規範

```bash
#!/bin/bash

# Script description
# Usage: bash scripts/your-script.sh [args]

set -e  # Exit on error

# Get project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$PROJECT_ROOT"

# Your script logic here
```

### 添加 npm script

在 `package.json` 中添加對應个 npm script：

```json
{
  "scripts": {
    "your-command": "bash scripts/your-script.sh"
  }
}
```

這樣使用者就可以用 `npm run your-command` 來執行。
