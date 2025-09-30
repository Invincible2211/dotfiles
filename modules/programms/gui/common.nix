{pkgs, ...}: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
        "libsoup-2.74.3"
        "libxml2-2.13.8"
    ];
  };

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
    plex-desktop
    citrix_workspace
    vscodium
  ];

}
