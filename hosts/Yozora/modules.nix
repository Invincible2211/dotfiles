# Yozora - GNOME workstation
{...}: {
  imports = [
    ../../modules/profiles/desktop/gnome-full.nix
    ../../modules/profiles/hardware/desktop.nix
    ../../modules/profiles/roles/workstation.nix
  ];

  # Host-specific configuration
  modules = {
    system.kernel.enable = true;
  };
}
