{
  config,
  lib,
  username,
  ...
}: let
  extensions = with pkgs.gnomeExtensions; [
    appindicator
  ];
in {
  options.modules.gnome.enable = lib.mkEnableOption "gnome";
  config = lib.mkIf config.modules.gnome.enable {
    enviorment.systemPackages = extensions;
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
    };
  };
}
