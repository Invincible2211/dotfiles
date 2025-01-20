{
  username,
  pkgs,
  ...
}: let
  extensions = with pkgs.gnomeExtensions; [
    appindicator
  ];
  wallpaperImg = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/wallpapers/nix-wallpaper-nineish-solarized-dark.png";
    hash = "sha256-ZBrk9izKvsY4Hzsr7YovocCbkRVgUN9i/y1B5IzOOKo";
  };
in {
  environment.systemPackages = extensions;
  home-manager.users.${username}.dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad".click-method = "default";
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    "org/gnome/shell" = {
      enabled-extensions = map (e: e.extensionUuid) extensions;
      favorite-apps = [
        "kitty.desktop"
        "org.gnome.Nautilus.desktop"
        "firefox.desktop"
        "idea-ultimate.desktop"
        "vesktop.desktop"
        "spotify.desktop"
        "obsidian.desktop"
      ];
    };
    "org/gnome/desktop/interface" = {
      clock-show-seconds = false;
      clock-show-weekday = true;
      enable-hot-corners = false;
      show-battery-percentage = true;
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file://${wallpaperImg}";
      picture-uri-dark = "file://${wallpaperImg}";
      primary-color = "#ff7800";
    };
  };
}
