{
  config,
  lib,
  pkgs,
  username,
  ...
}: let
  package = pkgs.git;
in {
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
      aliases = {
        s = "status -s";
        st = "status";
        ci = "commit";
        ciam = "commit --amend --no-edit";
        co = "checkout";
        d = "diff";
        ds = "diff --staged";
        a = "add";
        aa = "add --all";
        lg = "log --pretty=oneline --decorate --graph --abbrev-commit -30";
        rt = "restore";
        rts = "restore --staged";
      };
    };
  };
}
