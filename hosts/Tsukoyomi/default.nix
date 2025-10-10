{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {wfetch = inputs.wfetch.packages.${pkgs.system}.default;})
  ];

  system.stateVersion = "25.05";

  modules = {
    git.enable = true;
    programms.gui.browser.firefox.enable = true;
    boot.systemboot.enable = true;
    boot.plymouth.enable = true;
  };
}
