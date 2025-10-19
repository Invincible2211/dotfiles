{
  pkgs,
  lib,
  imagerepo,
  internalName,
  username,
  ...
}: let
  wallpaperDir = "/home/${username}/Bilder/Wallpapers";
  sourceWallpaperDir = "${imagerepo}/" + lib.toLower internalName + "/wallpapers";

  wallpaper-switch = pkgs.writeShellScriptBin "wallpaper-switch" ''
    #!/usr/bin/env bash

    WALLPAPER_DIR="${wallpaperDir}"
    STATE_FILE="$HOME/.config/swww/current-wallpaper"

    # Ensure state file exists
    mkdir -p "$(dirname "$STATE_FILE")"
    touch "$STATE_FILE"

    # Get all wallpapers (follow symlinks with -L)
    mapfile -t WALLPAPERS < <(find -L "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort)

    if [ ''${#WALLPAPERS[@]} -eq 0 ]; then
      echo "No wallpapers found in $WALLPAPER_DIR"
      exit 1
    fi

    # Get current wallpaper
    CURRENT=$(cat "$STATE_FILE" 2>/dev/null || echo "")

    # Find current index
    CURRENT_INDEX=-1
    for i in "''${!WALLPAPERS[@]}"; do
      if [ "''${WALLPAPERS[$i]}" = "$CURRENT" ]; then
        CURRENT_INDEX=$i
        break
      fi
    done

    # Calculate next/prev index
    case "$1" in
      next)
        NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ''${#WALLPAPERS[@]} ))
        ;;
      prev)
        if [ $CURRENT_INDEX -le 0 ]; then
          NEXT_INDEX=$(( ''${#WALLPAPERS[@]} - 1 ))
        else
          NEXT_INDEX=$(( CURRENT_INDEX - 1 ))
        fi
        ;;
      *)
        echo "Usage: wallpaper-switch [next|prev]"
        exit 1
        ;;
    esac

    NEW_WALLPAPER="''${WALLPAPERS[$NEXT_INDEX]}"

    # Set wallpaper with swww (simple transition for better compatibility with rotated displays)
    ${pkgs.swww}/bin/swww img "$NEW_WALLPAPER" \
      --transition-type simple \
      --transition-duration 1

    # Save state
    echo "$NEW_WALLPAPER" > "$STATE_FILE"

    # Show preview notification with image
    if command -v notify-send &> /dev/null; then
      ${pkgs.libnotify}/bin/notify-send -i "$NEW_WALLPAPER" "Wallpaper Changed" "$(basename "$NEW_WALLPAPER")"
    fi
  '';
in {
  environment.systemPackages = [
    pkgs.swww
    pkgs.waypaper
    wallpaper-switch
  ];

  # Symlink wallpapers from image-repo to user directory
  hm.home.file."Bilder/Wallpapers" = lib.mkIf (builtins.pathExists sourceWallpaperDir) {
    source = sourceWallpaperDir;
    recursive = true;
  };

  # Start swww daemon with Hyprland
  hm.wayland.windowManager.hyprland.settings.exec-once = [
    "${pkgs.swww}/bin/swww-daemon"
  ];

  # Waypaper config for GUI wallpaper selection
  hm.home.file.".config/waypaper/config.ini".text = ''
    [Settings]
    folder = ${wallpaperDir}
    wallpaper = ${wallpaperDir}/default.png
    backend = swww
    monitors = All
    fill = fill
    sort = name
    color = #1e1e2e
    subfolders = False
    number_of_columns = 3
    swww_transition_type = fade
    swww_transition_duration = 2
  '';
}
