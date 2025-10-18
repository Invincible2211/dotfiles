# Full GNOME setup - complete desktop environment
{...}: {
  imports = [./common.nix];

  modules = {
    system.gnome.enable = true;
    programms.gui = {
      common.enable = true;
      browser.firefox.enable = true;
      theming.stylix.enable = true;
      vm.virtualbox.enable = true;
    };
  };
}
