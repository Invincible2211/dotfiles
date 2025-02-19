{
  config,
  username,
  ...
}: let
  profileBaseConfig = {
    settings = {
      "browser.toolbars.bookmarks.visibility" = "always";
      "devtools.toolbox.host" = "right";
    };
  };
  extensions = with config.nur.repos.rycee.firefox-addons; [
    ublock-origin
  ];
in {
  hm = {
    programs.firefox = {
      enable = true;
      profiles = {
        private =
          profileBaseConfig
          // {
            id = 0;
            isDefault = true;
            extensions =
              extensions
              ++ (with config.nur.repos.rycee.firefox-addons; [
                ]);
          };
        work =
          profileBaseConfig
          // {
            id = 1;
            extensions =
              extensions
              ++ (with config.nur.repos.rycee.firefox-addons; [
                ]);
          };
      };
    };

    xdg.desktopEntries.firefoxWork = {
      name = "Firefox Work";
      genericName = "Web Browser";
      exec = "firefox -P work";
      icon = "firefox";
      terminal = false;
      categories = ["Application" "Network" "WebBrowser"];
      mimeType = ["text/html" "text/xml"];
    };
  };
}
