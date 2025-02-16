{
  config,
  pkgs,
  lib,
  ...
}: {
  # Kernel-Parameter für Docker und datenbankintensive Anwendungen
  boot.kernel.sysctl = {
    "kernel.shmmni" = 32768;
    "vm.max_map_count" = 2147483647;
    "fs.aio-max-nr" = 2147483647;
  };

  # Ulimit-Einstellungen für Docker und andere Services
  systemd.services.docker = {
    serviceConfig = {
      LimitNOFILE = 1048576;
      LimitMEMLOCK = "infinity";
    };
  };
}
