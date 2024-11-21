{
  config,
  lib,
  username,
  ...
}: {
  options.modules.gnome.enable = lib.mkEnableOption "gnome";

  config = lib.mkIf config.modules.gnome.enable {
    home-manager.users.${username}.dconf.settings = {
      "org/gnome/desktop/peripherals/touchpad".click-method = "default";
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/shell".favorite-apps = [
        "idea-ultimate.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Console.desktop"
        "spotify.desktop"
        "vesktop.desktop"
        "obsidian.desktop"
      ];
    };
  };
}
