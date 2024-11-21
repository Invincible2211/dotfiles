{
  username,
  name,
  ...
}: {
  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /home/${username}/dotfiles/.#${name}";
    nfmt = "nix fmt -I /home/${username}/dotfiles";
  };
}
