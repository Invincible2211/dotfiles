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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  modules = {
    git.enable = true;
    gnome.enable = true;
    applications.firefox.enable = true;
  };
}
