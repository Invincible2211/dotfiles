{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    hyprpanel
  ];

  # Hyprpanel will be started automatically by Hyprland
  hm.wayland.windowManager.hyprland.settings.exec-once = [
    "hyprpanel"
  ];
}
