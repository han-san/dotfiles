addons:
{
  enable = true;
  profiles.default = {
    extensions = with addons; [
      ublock-origin
      decentraleyes
      facebook-container
      keepassxc-browser
      violentmonkey
    ];
    id = 0;
    settings = {
      # "browser.safebrowsing.malware.enabled" = false;
      # "browser.safebrowsing.phishing.enabled" = false;

      "browser.tabs.drawInTitlebar" = true;

      # When to show the bookmark toolbar
      "browser.toolbars.bookmarks.visibility" = "never";

      # Default to DDG search
      "browser.urlbar.placeholderName" = "DuckDuckGo";

      # DRM
      "media.eme.enabled" = true;

      # Clean up the home screen.
      "browser.newtabpage.activity-stream.showSearch" = false;
      "browser.newtabpage.activity-stream.feeds.topsites" = false;
      "browser.newtabpage.activity-stream.feeds.snippets" = false;
      "browser.newtabpage.activity-stream.feeds.section.highlights" = false;

      # Search suggestions
      "browser.search.suggest.enabled" = false;

      # Tracking
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
      "network.cookie.cookieBehavior" = 1;
      "browser.contentblocking.category" = "custom";

      # Delete cookie on close
      "network.cookie.lifetimePolicy" = 2;

      # Don't ask to save logins
      "signon.rememberSignons" = false;

      "app.shield.optoutstudies.enabled" = false;

      # Disable extension recommendations
      "browser.discovery.enabled" = false;

      # https only
      "dom.security.https_only_mode" = true;

      # Compact ui
      "browser.compactmode.show" = true;
      "browser.uidensity" = 1;

      # Remove pocket
      "extensions.pocket.enabled" = false;

      # Remove firefox account (sync)
      "identity.fxaccounts.enabled" = false;
    };
  };
}
