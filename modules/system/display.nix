{config, ...}: let
  isGnome = config.modules.system.gnome.enable or false;
  isHyprland = config.modules.system.compositor.hyprland.enable or false;
in {
  # Enable X11 windowing system (needed for GNOME and Xwayland)
  services.xserver = {
    enable = true;

    # Configure keymap
    xkb = {
      layout = "de";
      variant = "";
    };

    # Enable GNOME if configured
    displayManager.gdm = {
      enable = isGnome || isHyprland;
      wayland = isHyprland;
    };
    desktopManager.gnome.enable = isGnome;

    # Uncomment if needed
    # videoDrivers = [
    #   "displaylink"
    # ];
  };

  # Console keymap
  console.keyMap = "de";

  # Enable keyring
  services.gnome.gnome-keyring.enable = true;
}
