{
  config,
  lib,
  username,
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

  # Allow passwordless sudo for system activation (remote deployments)
  security.sudo.extraRules = [{
    users = [username];
    commands = [{
      command = "/nix/store/*/bin/switch-to-configuration";
      options = ["NOPASSWD"];
    }];
  }];
}
