{
  username,
  internalName,
  flakePath,
  ...
}: {
  programs.nh = {
    enable = true;
    flake = flakePath;
  };
  environment.shellAliases = {
    rebuild = "nh os switch -H ${internalName} -- ";
    nfmt = "nix fmt -I /home/${username}/dotfiles";
    #gnome
    watch = "dconf watch /";
    gnreset = "dconf reset -f /";
    #git commands
    gadd = "";
    gadda = "git add --all";
    gc = "git commit";
    gpush = "git push";
    gpull = "git pull";
    gfetch = "git fetch";
  };
}
