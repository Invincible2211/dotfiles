# Tsukoyomi - Hyprland workstation with rotated display
{lib, ...}: {
  imports = [
    ../../modules/profiles/desktop/hyprland-full.nix
    ../../modules/profiles/hardware/laptop.nix
    ../../modules/profiles/roles/workstation.nix
  ];

  # Host-specific overrides
  modules = {
    # Disable docker from workstation profile
    programms.cli.docker.enable = lib.mkForce false;

    # SSH for remote deployments
    system.ssh.enable = true;
  };
}
