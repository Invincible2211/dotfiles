# Common desktop profile - basics every desktop needs
{...}: {
  imports = [../base/minimal.nix];

  modules = {
    system = {
      audio.enable = true;
      display.enable = true;
      font.enable = true;
    };
    services.printing.enable = true;
    programms.cli.kitty.enable = true;
  };
}
