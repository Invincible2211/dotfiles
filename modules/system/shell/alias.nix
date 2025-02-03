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
    watch = "dconf watch /";
    gnreset = "dconf reset -f /";
    g = "git";
    letmeout = "poweroff";
    wf = "wfetch --waifu";
  };
}
