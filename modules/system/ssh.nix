{
  config,
  lib,
  ...
}: {
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
    openFirewall = true;
  };

  # Ensure SSH is started on boot
  systemd.services.sshd.wantedBy = lib.mkForce ["multi-user.target"];
}
