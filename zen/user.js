// Zen Browser preferences, applied at every startup.
//
// NOTE: user.js *pins* these values. Changing them in Zen's UI works for the
// session, but they revert on the next restart. Keep this list to settings you
// deliberately want locked; everything else belongs in the UI.
//
// prefs.js is deliberately NOT tracked - it is rewritten on shutdown and holds
// machine state (push notification IDs, session UUIDs, search counts).

// Required for chrome/userChrome.css to load at all.
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Zen UI
user_pref("zen.view.compact.enable-at-startup", true);
user_pref("zen.pinned-tab-manager.restore-pinned-tabs-to-pinned-url", true);
user_pref("zen.swipe.is-fast-swipe", false);

// Browser behaviour
user_pref("browser.startup.page", 1);
user_pref("browser.ctrlTab.sortByRecentlyUsed", true);
user_pref("browser.bookmarks.showMobileBookmarks", true);
user_pref("accessibility.typeaheadfind.flashBar", 0);
