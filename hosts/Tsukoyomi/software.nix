# Software choices for Tsukoyomi
{lib, ...}: {
  modules = {
    # Disable docker from workstation profile
    programms.cli.docker.enable = lib.mkForce false;

    # SSH for remote deployments
    system.ssh.enable = true;

    # Boot configuration
    boot = {
      systemboot.enable = true;
      plymouth.enable = true;
    };

    # Git enabled
    git.enable = true;

    # Firefox as fallback browser
    programms.gui.browser.firefox.enable = true;
  };
}
