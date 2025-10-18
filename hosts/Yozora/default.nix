{...}: {
  imports = [
    ./hardware-configuration.nix
    ./modules.nix
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
