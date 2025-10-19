{
  config,
  lib,
  pkgs,
  ...
}: let
  # Hyprland startup wrapper script
  hyprlandRun = pkgs.writeShellScript "hyprland-run" ''
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=Hyprland
    export XDG_CURRENT_DESKTOP=Hyprland

    # Start Hyprland with systemd integration
    systemd-run --user --scope --collect --quiet --unit=hyprland \
      systemd-cat --identifier=hyprland ${pkgs.hyprland}/bin/Hyprland $@
  '';
in {
  options = {
    # Tuigreet configuration options
    time = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Display current date and time";
    };

    remember = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Remember last logged in username";
    };

    rememberSession = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Remember last used session";
    };

    rememberUserSession = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Remember session per user (only saved on successful login)";
    };

    greeting = lib.mkOption {
      type = lib.types.str;
      default = "Welcome to NixOS!";
      description = "Greeting message displayed at login";
    };

    greetingAlignment = lib.mkOption {
      type = lib.types.enum ["left" "center" "right"];
      default = "center";
      description = "Alignment of greeting text";
    };

    width = lib.mkOption {
      type = lib.types.int;
      default = 80;
      description = "Width of the prompt container in columns";
    };

    defaultSession = lib.mkOption {
      type = lib.types.str;
      default = "Hyprland";
      description = "Default session command to run";
    };

    extraArgs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Additional command line arguments for tuigreet";
      example = ["--issue" "--power-shutdown 'systemctl poweroff'"];
    };

    autologin = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable autologin on first boot";
      };

      user = lib.mkOption {
        type = lib.types.str;
        default = config.modules.system.user.username or "user";
        description = "User to autologin as";
      };
    };
  };

  config = cfg: {
    # Disable other display managers
    services.xserver.displayManager.gdm.enable = lib.mkForce false;

    # Enable greetd service
    services.greetd = {
      enable = true;
      settings = {
        default_session = let
          # Build tuigreet command with options
          tuigreetCmd =
            lib.concatStringsSep " " ([
                "${pkgs.greetd.tuigreet}/bin/tuigreet"
                "--greeting '${cfg.greeting}'"
                "--greet-align ${cfg.greetingAlignment}"
                "--width ${toString cfg.width}"
                "--cmd ${hyprlandRun}"
              ]
              ++ lib.optional cfg.time "--time"
              ++ lib.optional cfg.remember "--remember"
              ++ lib.optional cfg.rememberSession "--remember-session"
              ++ lib.optional cfg.rememberUserSession "--remember-user-session"
              ++ cfg.extraArgs);
        in {
          command = tuigreetCmd;
          user = "greeter";
        };

        # Optional autologin on first boot
        initial_session = lib.mkIf cfg.autologin.enable {
          command = "${hyprlandRun}";
          user = cfg.autologin.user;
        };
      };
    };

    # Ensure cache directory exists for tuigreet
    systemd.tmpfiles.rules = [
      "d /var/cache/tuigreet 0755 greeter greeter -"
    ];

    # Environment setup
    environment.systemPackages = with pkgs; [
      greetd.tuigreet
    ];
  };
}
