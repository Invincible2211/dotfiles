{username, name, ...}: {
  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /home/${username}/dotfiles/.#${name}";
    sysconf = "nano /home/kaguya/dotfiles/configuration.nix";
  };
}
