{
  # Bootloader.
  #boot.loader = {
  #  efi = {
  #    canTouchEfiVariables = true;
  #    efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
  #  };
  #  grub = {
  #    efiSupport = true;
  #    #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
  #    device = "nodev";
  #  };
  #};
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.plymouth.enable = true;

  modules = {
    git.enable = true;
    system.gnome.enable = true;
    programms.firefox.enable = true;
  };
}
