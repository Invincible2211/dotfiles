{...}: {
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      efiSupport = true;
      device = "dev/nvme0n1";
      configurationLimit = 5;
    };
  };
}
