# Lee-Su-Threads 你是誰

A Chrome extension that extracts "About this profile" information from Threads.com without needing to visit each user's profile page.

## Features

- **Automatic Extraction**: Intercepts API responses when profile info is loaded on the feed
- **Floating Panel**: Shows all extracted profiles in a draggable panel on the page
- **Profile Badges**: Displays location and join date directly on posts in the feed
- **Export Data**: Export all extracted profiles as JSON
- **Clipboard Copy**: Quick copy all profile data to clipboard
- **Persistent Cache**: Profiles are cached for 24 hours

## Extracted Information

For each profile, the extension captures:

- **Display Name**: The user's full name
- **Username**: The @handle
- **Location**: "Based in" location (e.g., "Taiwan")
- **Join Date**: When they joined (e.g., "March 2024 · 100M+")
- **Profile Image**: Avatar URL

## Installation

### Developer Mode (Recommended for now)

1. Open Chrome and navigate to `chrome://extensions/`
2. Enable **Developer mode** (toggle in top-right corner)
3. Click **Load unpacked**
4. Select the `thread-my-home` folder
5. The extension icon should appear in your toolbar

### Usage

1. Navigate to [threads.com](https://www.threads.com)
2. Browse your feed normally
3. When Threads loads "About this profile" data (usually when you interact with posts), the extension captures it
4. View extracted profiles in:
   - The floating panel (bottom-right of the page)
   - The extension popup (click the extension icon)
5. Export or copy data as needed

## How It Works

The extension intercepts network requests to Threads' internal API endpoint:

```
/async/wbloks/fetch/?appid=com.bloks.www.text_post_app.about_this_profile_async_action
```

When this endpoint returns data, the extension parses the Bloks response format and extracts:

- User name and handle from `bk.components.RichText`
- Location and join date from `bk.components.Text` components
- Profile image from `bk.components.Image`

## File Structure

```
thread-my-home/
├── manifest.json      # Extension manifest (MV3)
├── background.js      # Service worker for caching
├── content.js         # Content script for UI
├── injected.js        # Network interceptor (injected into page)
├── styles.css         # Styles for badges and panel
├── popup.html         # Extension popup UI
├── popup.js           # Popup logic
├── icons/
│   ├── icon16.png
│   ├── icon48.png
│   └── icon128.png
└── README.md
```

## Privacy

- All data is stored locally in Chrome's storage
- No data is sent to external servers
- Cache is automatically cleared after 24 hours

## Limitations

- Only captures profile info when Threads loads it (you may need to interact with posts)
- Threads may change their API format, which could break parsing
- Some profiles may not have location or other optional fields

## Development

To modify the extension:

1. Edit the source files
2. Go to `chrome://extensions/`
3. Click the refresh icon on the extension card
4. Reload the Threads page

## License

MIT License - Feel free to modify and distribute.
