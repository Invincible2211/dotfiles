{
  username,
  internalName,
  ...
}: {
  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /home/${username}/dotfiles/.#${internalName}";
    nfmt = "nix fmt -I /home/${username}/dotfiles";
  };
}
