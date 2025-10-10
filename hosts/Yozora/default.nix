{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.overlays = [
    inputs.self.overlays.nixpkgs
    (final: prev: {wfetch = inputs.wfetch.packages.${pkgs.system}.default;})
  ];

  system.stateVersion = "24.05";

  modules = {
    git.enable = true;
    system.gnome.enable = true;
    programms.gui.browser.firefox.enable = true;
    boot.systemboot.enable = true;
    boot.plymouth.enable = true;
  };

}
