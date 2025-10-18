# Desktop hardware profile - performance over power saving
{...}: {
  # Performance over power saving
  powerManagement.cpuFreqGovernor = "performance";

  # No laptop features
  services.tlp.enable = false;
}
