# Minimal base profile - essentials for every system
{...}: {
  modules = {
    system = {
      nix.enable = true;
      homemanager.enable = true;
      user.enable = true;
      localisation.enable = true;
      network.enable = true;
      shell = {
        alias.enable = true;
        tools.enable = true;
      };
    };
    git.enable = true;
  };
}
