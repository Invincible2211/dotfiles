{
  config,
  pkgs,
  lib,
  imagerepo,
  internalName,
  username,
  ...
}: let
  # Get wallpaper path from imagerepo
  wallpaperPath = "${imagerepo}/" + lib.toLower internalName + "/nix-wallpaper-anime.png";
in {
  options = {
    wallpaperBlur = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable blur on wallpaper background";
    };

    showProfilePicture = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Show user profile picture";
    };

    profilePicturePath = lib.mkOption {
      type = lib.types.str;
      default = "~/.face";
      description = "Path to profile picture";
    };

    showDateTime = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Show date and time";
    };

    show12Hour = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Use 12-hour time format instead of 24-hour";
    };

    greeting = lib.mkOption {
      type = lib.types.str;
      default = "Hi there, $USER";
      description = "Greeting text shown on lock screen";
    };

    inputFieldStyle = lib.mkOption {
      type = lib.types.enum ["modern" "minimal" "classic"];
      default = "modern";
      description = "Style of the password input field";
    };
  };

  config = cfg: {
    # Enable PAM for hyprlock authentication
    security.pam.services.hyprlock = {};

    # Configure hyprlock via home-manager
    hm.programs.hyprlock = {
      enable = true;

      settings = lib.mkForce {
        # General settings
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
          grace = 0;
          no_fade_in = false;
        };

        # Background with wallpaper and blur
        background = [
          {
            monitor = "";
            path = wallpaperPath;
            blur_passes = if cfg.wallpaperBlur then 3 else 0;
            blur_size = 7;
            noise = 0.0117;
            contrast = 0.8916;
            brightness = 0.8;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.0;
          }
        ];

        # Profile picture (optional)
        image = lib.mkIf cfg.showProfilePicture [
          {
            monitor = "";
            path = cfg.profilePicturePath;
            size = 120;
            rounding = -1; # Perfect circle
            border_size = 3;
            border_color = "rgb(cba6f7)"; # Catppuccin Mauve
            position = "0, 120";
            halign = "center";
            valign = "center";
          }
        ];

        # Labels
        label = lib.flatten [
          # Time display (optional)
          (lib.optional cfg.showDateTime {
            monitor = "";
            text = "cmd[update:1000] echo \"<span font_weight='bold'>$(date +\"${if cfg.show12Hour then "%I:%M %p" else "%H:%M"}\")</span>\"";
            color = "rgba(216, 222, 233, 0.95)";
            font_size = 90;
            font_family = "JetBrains Mono";
            position = "0, ${if cfg.showProfilePicture then "280" else "200"}";
            halign = "center";
            valign = "center";
          })

          # Date display (optional)
          (lib.optional cfg.showDateTime {
            monitor = "";
            text = "cmd[update:1000] echo \"<span font_weight='light'>$(date +\"%A, %d %B\")</span>\"";
            color = "rgba(216, 222, 233, 0.75)";
            font_size = 20;
            font_family = "JetBrains Mono";
            position = "0, ${if cfg.showProfilePicture then "190" else "110"}";
            halign = "center";
            valign = "center";
          })

          # Greeting
          {
            monitor = "";
            text = cfg.greeting;
            color = "rgba(216, 222, 233, 0.85)";
            font_size = 22;
            font_family = "JetBrains Mono";
            position = "0, ${if cfg.showProfilePicture then "-50" else "-20"}";
            halign = "center";
            valign = "center";
          }

          # Keyboard layout indicator
          {
            monitor = "";
            text = "$LAYOUT";
            color = "rgba(216, 222, 233, 0.65)";
            font_size = 14;
            font_family = "JetBrains Mono";
            position = "20, 20";
            halign = "left";
            valign = "bottom";
          }

          # Failed attempts counter
          {
            monitor = "";
            text = "$FAIL <i>($ATTEMPTS)</i>";
            color = "rgba(243, 139, 168, 0.95)"; # Catppuccin Red
            font_size = 16;
            font_family = "JetBrains Mono";
            position = "0, -40";
            halign = "center";
            valign = "center";
          }
        ];

        # Input field with different styles
        input-field = [
          (if cfg.inputFieldStyle == "modern" then {
            monitor = "";
            size = "350, 60";
            outline_thickness = 2;
            dots_size = 0.25;
            dots_spacing = 0.3;
            dots_center = true;
            outer_color = "rgba(203, 166, 247, 0.4)"; # Catppuccin Mauve
            inner_color = "rgba(30, 30, 46, 0.7)"; # Catppuccin Base
            font_color = "rgb(205, 214, 244)"; # Catppuccin Text
            check_color = "rgb(166, 227, 161)"; # Catppuccin Green
            fail_color = "rgb(243, 139, 168)"; # Catppuccin Red
            fade_on_empty = false;
            fade_timeout = 1000;
            rounding = 15;
            placeholder_text = "<span foreground=\"##cdd6f4\">🔒 Enter Password</span>";
            fail_text = "<i>Authentication failed</i>";
            hide_input = false;
            capslock_color = "rgb(249, 226, 175)"; # Catppuccin Yellow
            position = "0, -150";
            halign = "center";
            valign = "center";
          }
          else if cfg.inputFieldStyle == "minimal" then {
            monitor = "";
            size = "300, 50";
            outline_thickness = 1;
            dots_size = 0.2;
            dots_spacing = 0.3;
            dots_center = true;
            outer_color = "rgba(205, 214, 244, 0.2)";
            inner_color = "rgba(30, 30, 46, 0.5)";
            font_color = "rgb(205, 214, 244)";
            check_color = "rgb(166, 227, 161)";
            fail_color = "rgb(243, 139, 168)";
            fade_on_empty = true;
            rounding = 25;
            placeholder_text = "<span foreground=\"##cdd6f4\">Password</span>";
            hide_input = false;
            position = "0, -150";
            halign = "center";
            valign = "center";
          }
          else {
            # classic style
            monitor = "";
            size = "280, 55";
            outline_thickness = 3;
            dots_size = 0.3;
            dots_spacing = 0.2;
            dots_center = false;
            outer_color = "rgb(137, 180, 250)"; # Catppuccin Blue
            inner_color = "rgba(30, 30, 46, 0.8)";
            font_color = "rgb(205, 214, 244)";
            check_color = "rgb(166, 227, 161)";
            fail_color = "rgb(243, 139, 168)";
            fade_on_empty = false;
            rounding = 10;
            placeholder_text = "<i>Password</i>";
            hide_input = false;
            position = "0, -150";
            halign = "center";
            valign = "center";
          })
        ];
      };
    };

    # Update Hyprland keybinding to use hyprlock
    hm.wayland.windowManager.hyprland.settings.bind = lib.mkAfter [
      "$mod, L, exec, hyprlock"
    ];
  };
}
