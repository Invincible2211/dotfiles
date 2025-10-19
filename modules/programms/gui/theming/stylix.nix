{
  inputs,
  lib,
  pkgs,
  internalName,
  imagerepo,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];

  options.desktop.enable = lib.mkEnableOption "stylix.desktop";

  config = cfg: {
    hm.gtk.enable = lib.mkDefault cfg.desktop.enable;

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
      image = "${imagerepo}/" + lib.toLower internalName + "/nix-wallpaper-anime.png";
      polarity = "dark";
    };
  };
}
