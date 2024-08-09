{ config, ... }:
{
  home.file."sideberry.css" = {
    target = ".mozilla/firefox/default/chrome/sideberry.css";
    text = ''
      #TabsToolbar {
        display: none;
      }

      #sidebar-header {
        display: none;
      }
    '';
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "Default";
      settings = {
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.drawInTitlebar" = true;
        "svg.context-properties.content.enabled" = true;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };

      userChrome = ''
        @import "sideberry.css";
      '';

      extensions = with config.nur.repos.rycee.firefox-addons; [
        stylus
        sidebery
        ublock-origin
        sponsorblock
        violentmonkey
        foxyproxy-standard
        keepassxc-browser
        istilldontcareaboutcookies
      ];
    };
  };
}
