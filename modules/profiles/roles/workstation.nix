# Workstation role - development tools and utilities
{...}: {
  modules = {
    programms.cli = {
      nixvim.enable = true;
      docker.enable = true;
    };
  };
}
