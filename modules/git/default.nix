{
  config,
  lib,
  pkgs,
  username,
  ...
}: let
  package = pkgs.git;
in {
  options.modules.git = {
    enable = lib.mkEnableOption "git";
  };

  config = lib.mkIf config.modules.git.enable {
    environment.systemPackages = [package];
    home-manager.users.${username} = {
      programs.git = {
        inherit package;
        enable = true;
        delta = {
          enable = true;
          options = {
            line-numbers = true;
            side-by-side = true;
            navigate = true;
          };
        };
        userEmail = "58395689+Invincible2211@users.noreply.github.com";
        userName = "Invincible2211";
      };
    };
  };
}
