{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.overlays = [
    inputs.nix-xilinx.overlay
  ];

  modules = {
    git.enable = true;
    system.gnome.enable = true;
    programms.firefox.enable = true;
  };

  environment.systemPackages = [
    pkgs.vivado
  ];
}
