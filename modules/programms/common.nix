{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vesktop
    obsidian
    spotify
    protonmail-desktop
    jetbrains.pycharm-professional
    jetbrains.idea-ultimate
    jetbrains.datagrip
    fastfetch
    teams-for-linux
    gnumake
    python3
    wfetch
    gnome-tweaks
    librewolf
    logisim-evolution
    virtualbox
    nautilus
    kalker
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
}
