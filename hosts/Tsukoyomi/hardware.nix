# Hardware-specific configuration for Tsukoyomi
{...}: {
  # Rotated display configuration
  # Monitor is physically rotated 90 degrees (portrait mode)
  hm.wayland.windowManager.hyprland.settings.monitor = ",preferred,auto,1,transform,3";

  # Disable USB autosuspend to prevent keyboard/mouse from going to sleep
  # (RGB lighting turns off and first keypress/click is consumed)
  boot.kernelParams = ["usbcore.autosuspend=-1"];
}
