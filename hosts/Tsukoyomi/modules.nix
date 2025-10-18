{...}: {
  modules = {
    programms = {
      cli = {
        kitty.enable = true;
        nixvim.enable = true;
        docker.enable = false;
      };
      gui = {
        common.enable = false;
        browser = {
          firefox.enable = true;
        };
        theming = {
          stylix.enable = true;
        };
        vm = {
          virtualbox.enable = false;
        };
      };
    };
    services.printing.enable = true;
    system = {
      kernel.enable = false;
      audio.enable = true;
      display.enable = true;
      font.enable = true;
      gnome.enable = false;
      ssh.enable = true;
      compositor = {
        hyprland.enable = true;
        waybar.enable = true;
        waylock.enable = true;
        wallpaper.enable = true;
      };
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
