# Full Hyprland setup - complete desktop environment
{...}: {
  imports = [./hyprland-minimal.nix];

  modules = {
    system.compositor = {
      hyprpanel.enable = true;
      wallpaper.enable = true;
    };
    programms.gui = {
      browser.zen.enable = true;
      social.vesktop.enable = true;
      theming.stylix.enable = true;
    };
  };
}
