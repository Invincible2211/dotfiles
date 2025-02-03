{
  inputs,
  lib,
  pkgs,
  ...
}: let
  wallpaperImg = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/wallpapers/nix-wallpaper-nineish-solarized-dark.png";
    hash = "sha256-ZBrk9izKvsY4Hzsr7YovocCbkRVgUN9i/y1B5IzOOKo";
  };
in {
  imports = [inputs.stylix.nixosModules.stylix];

  options.desktop.enable = lib.mkEnableOption "stylix.desktop";

  config = cfg: {
    hm.gtk.enable = lib.mkDefault cfg.desktop.enable;

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/sakura.yaml";
      image = wallpaperImg;
      polarity = "dark";
    };
  };
}
