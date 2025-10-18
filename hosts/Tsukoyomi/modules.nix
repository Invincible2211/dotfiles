# Tsukoyomi - Hyprland workstation with rotated display
{...}: {
  imports = [
    # Profiles
    ../../modules/profiles/desktop/hyprland-full.nix
    ../../modules/profiles/hardware/laptop.nix
    ../../modules/profiles/roles/workstation.nix

    # Host-specific configuration
    ./hardware.nix
    ./software.nix
  ];
}
