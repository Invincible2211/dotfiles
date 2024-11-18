{
  config,
  lib,
  username,
  ...
}: {
  options.modules.gnome.enable = lib.mkEnableOption "gnome";

  config = lib.mkIf config.modules.gnome.enable {
    home-manager.users.${username}.dconf.settings."org/gnome/desktop/peripherals/touchpad".click-method = "default";
  };
}
