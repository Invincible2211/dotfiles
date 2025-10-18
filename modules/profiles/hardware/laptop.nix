# Laptop hardware profile - power management, battery optimization
{pkgs, ...}: {
  # Power management
  services.tlp.enable = true;
  services.upower.enable = true;

  # Laptop-specific settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  # Battery optimization
  powerManagement.powertop.enable = true;

  environment.systemPackages = with pkgs; [
    acpi
    powertop
  ];
}
