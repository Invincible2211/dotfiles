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
    wfetch
    gnome-tweaks
    librewolf
    nautilus
    kalker
    openconnect
    onlyoffice-desktopeditors
  ];
  
}
