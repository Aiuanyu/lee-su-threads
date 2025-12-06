# Lee-Su-Threads 你是誰

**這個 repo 已經不再維護。**

上游 [`meettomorrow/lee-su-threads`](https://github.com/meettomorrow/lee-su-threads) 已經支援 Firefox，請前往該 repo 下載最新版本。

## 如何 build Firefox xpi

1. 前往 [meettomorrow/lee-su-threads](https://github.com/meettomorrow/lee-su-threads)
2. 下載最新的 zip 檔並解壓縮
3. 執行 `scripts/package.sh`（記得先 `chmod +x scripts/package.sh`）
4. build 好的 `.xpi` 會放在 `dist-zip/` 裡
5. 在 Firefox 的 `about:addons` 頁面，點擊齒輪圖示 -> "Install Add-on From File..." 即可安裝

---

## 功能

- **自動擷取**：瀏覽動態時自動載入作者的地點資訊
- **地點標籤**：在貼文時間旁顯示作者所在地點
- **快取機制**：已擷取的資料會快取 24 小時
- **匯出資料**：可將所有資料匯出為 JSON
- **速率限制保護**：被 Threads 限制時會自動暫停並提醒

## 擷取的資訊

- **地點**：作者設定的所在地（例如：台灣）
- **加入時間**：加入 Threads 的時間

## 截圖

![動態中的地點標籤](screenshots/feed-badge.png)

![擴充功能彈出視窗](screenshots/popup.png)

## 使用方式

1. 前往 [threads.com](https://www.threads.com)
2. 正常瀏覽動態
3. 擴充功能會自動在貼文旁顯示地點標籤
4. 點擊擴充功能圖示可查看所有已擷取的資料

## 隱私說明

- 所有資料僅儲存在本機瀏覽器儲存空間
- 不會將任何資料傳送到外部伺服器
- 快取會在 24 小時後自動清除

## 限制

- 需要 Threads 載入個人資料 API 才能擷取（通常瀏覽動態時會自動載入）
- 若 Threads 更改 API 格式，可能需要更新擴充功能
- 部分使用者可能未設定地點資訊

---

# Lee-Su-Threads

**This repo is no longer maintained.**

The upstream [`meettomorrow/lee-su-threads`](https://github.com/meettomorrow/lee-su-threads) now supports Firefox. Please visit the upstream repo to download the latest version.

## How to build Firefox xpi

1. Go to [meettomorrow/lee-su-threads](https://github.com/meettomorrow/lee-su-threads)
2. Download the latest zip and unzip it
3. Run `scripts/package.sh` (remember to `chmod +x scripts/package.sh` first)
4. The built `.xpi` will be in `dist-zip/`
5. In Firefox's `about:addons` page, click the gear icon -> "Install Add-on From File..." to install

---

### Features

- **Auto-fetch**: Automatically loads author location while browsing the feed
- **Location badges**: Shows location next to post timestamp
- **Caching**: Extracted data is cached for 24 hours
- **Export**: Export all data as JSON
- **Rate limit protection**: Auto-pauses and notifies when rate limited by Threads

### Screenshots

![Feed badge](screenshots/feed-badge.png)

![Popup](screenshots/popup.png)

### Usage

1. Navigate to [threads.com](https://www.threads.com)
2. Browse your feed normally
3. Location badges will automatically appear next to posts
4. Click the extension icon to view all extracted profiles

### Privacy

- All data is stored locally in the browser's storage
- No data is sent to external servers
- Cache is automatically cleared after 24 hours
