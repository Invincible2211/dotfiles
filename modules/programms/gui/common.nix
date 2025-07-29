{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vesktop
    obsidian
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
    plexamp
    citrix_workspace
  ];
}
