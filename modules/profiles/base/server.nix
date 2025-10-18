# Server profile - minimal + SSH, no GUI
{...}: {
  imports = [./minimal.nix];

  modules = {
    system.ssh.enable = true;
  };
}
