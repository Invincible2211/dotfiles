{pkgs, ...}: {
  environment.systemPackages = [pkgs.waylock];

  hm.home.file.".config/waylock/waylock.conf".text = ''
    # Waylock configuration

    # Color format: RRGGBBAA
    init-color=0x1e1e2e
    input-color=0x89b4fa
    fail-color=0xf38ba8
  '';
}
