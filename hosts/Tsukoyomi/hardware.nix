# Hardware-specific configuration for Tsukoyomi
{...}: {
  # Rotated display configuration
  # Monitor is physically rotated 90 degrees (portrait mode)
  hm.wayland.windowManager.hyprland.settings = {
    monitor = ",preferred,auto,1,transform,3";

    # Disable DPMS to prevent mouse input issues after idle
    misc = {
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
    };
  };
}
