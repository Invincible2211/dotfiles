{
  username,
  pkgs,
  ...
}: let
  extensions = with pkgs.gnomeExtensions; [
    appindicator
    open-bar
    forge
    space-bar
    no-overview
  ];
in {
  services.gnome.core-apps.enable = false;
  environment.systemPackages = extensions;
  environment.defaultPackages = [];

  #services.gnome.gdm.extraConfig = ''
  #  [greeter]
  #  Exclude=root
  #'';

  hm.dconf.settings = {
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
  };
}
