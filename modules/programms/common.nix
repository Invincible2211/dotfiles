{pkgs, ...}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vesktop
    obsidian
    spotify
    protonmail-desktop
    jetbrains.pycharm-professional
    jetbrains.idea-ultimate
    jetbrains.datagrip
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
}
