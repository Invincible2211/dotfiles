{
  username,
  internalName,
  flakePath,
  lib,
  inputs,
  ...
}: let
  imagePath = "${inputs.image-repo}/"+lib.toLower internalName+"/nix-snowflake-colours-akane.png";
in {
  programs.nh = {
    enable = true;
    flake = flakePath;
  };
  environment.shellAliases = {
    rebuild = "nh os switch -H ${internalName} -- ";
    nfmt = "nix fmt -I /home/${username}/dotfiles";
    watch = "dconf watch /";
    gnreset = "dconf reset -f /";
    g = "git";
    letmeout = "poweroff";
    letmefix = "reboot";
    wf = "wfetch --wallpaper " + imagePath;
  };
}
