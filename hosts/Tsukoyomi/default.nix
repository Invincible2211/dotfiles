{...}: {
  imports = [
    ./hardware-configuration.nix
    ./modules.nix
  ];

  system.stateVersion = "25.05";
}
