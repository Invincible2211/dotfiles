{...}: {
  modules = {
    programms = {
      cli = {
        kitty.enable = true;
        nixvim.enable = true;
        docker.enable = true;
      };
      gui = {
        common.enable = true;
        browser = {
          firefox.enable = true;
        };
        theming = {
          stylix.enable = true;
        };
        vm = {
          virtualbox.enable = true;
        };
      };
    };
    services.printing.enable = true;
    system = {
      kernel.enable = true;
      audio.enable = true;
      display.enable = true;
      font.enable = true;
      gnome.enable = true;
      localisation.enable = true;
      network.enable = true;
      nix.enable = true;
      homemanager.enable = true;
      shell = {
        alias.enable = true;
        tools.enable = true;
      };
      user.enable = true;
    };
  };
}
