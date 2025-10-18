# Minimal Hyprland setup - compositor + screenlock only
{...}: {
  imports = [./common.nix];

  modules = {
    system.compositor = {
      hyprland.enable = true;
      waylock.enable = true;
    };
  };
}
