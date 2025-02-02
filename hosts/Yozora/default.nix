{
  pkgs,
  inputs,
  ...
}: {
  # Bootloader.
  #boot.loader = {
  #  efi = {
  #    canTouchEfiVariables = true;
  #    efiSysMountPoint = "/boot/efi";
  #  };
  #  grub = {
  #    efiSupport = true;
  #    device = "dev/nvme0n1";
  #    configurationLimit = 5;
  #  };
  #};
  #boot.loader.grub.c

  boot = {
    plymouth = {
      enable = true;
      theme = "deus_ex";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = ["deus_ex"];
        })
      ];
    };

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5;
      efi.canTouchEfiVariables = true;
    };
  };

  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.overlays = [
    inputs.nix-xilinx.overlay
    (final: prev: {wfetch = inputs.wfetch.packages.${pkgs.system}.default;})
  ];

  modules = {
    git.enable = true;
    system.gnome.enable = true;
    programms.firefox.enable = true;
    boot.systemboot.enable = true;
    boot.plymouth.enable = true;
  };

  environment.systemPackages = [
    pkgs.vivado
    pkgs.wfetch
  ];
}
