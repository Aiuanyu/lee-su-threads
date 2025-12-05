// Background service worker for Threads Profile Info Extractor

// Browser compatibility: Support both Chrome and Firefox
if (typeof browser === 'undefined') {
  var browser = chrome;
}

// Listen for messages from content script
chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
  if (message.type === 'PROFILE_INFO_EXTRACTED') {
    console.log('[Threads Extractor] Profile info received:', message.data);

    // Store the profile info
    chrome.storage.local.get(['profileCache'], (result) => {
      const cache = result.profileCache || {};
      const username = message.data.username;
      if (username) {
        cache[username] = {
          ...message.data,
          timestamp: Date.now()
        };
        chrome.storage.local.set({ profileCache: cache });
      }
    });
  }

  if (message.type === 'GET_CACHED_PROFILES') {
    chrome.storage.local.get(['profileCache'], (result) => {
      sendResponse(result.profileCache || {});
    });
    return true; // Keep channel open for async response
  }
});

// Clean up old cache entries (older than 24 hours)
chrome.runtime.onStartup.addListener(() => {
  chrome.storage.local.get(['profileCache'], (result) => {
    const cache = result.profileCache || {};
    const now = Date.now();
    const maxAge = 24 * 60 * 60 * 1000; // 24 hours

    const cleanedCache = {};
    for (const [username, data] of Object.entries(cache)) {
      if (now - data.timestamp < maxAge) {
        cleanedCache[username] = data;
      }
    }

    chrome.storage.local.set({ profileCache: cleanedCache });
  });
});
