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
    (final: prev: {wfetch = inputs.wfetch.packages.${pkgs.system}.default;})
  ];

  modules = {
    git.enable = true;
    system.gnome.enable = true;
    programms.firefox.enable = true;
    boot.systemboot.enable = true;
    boot.plymouth.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vivado
  ];
}
