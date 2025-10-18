{pkgs, ...}: {
  hm.home.packages = with pkgs; [
    zen-browser
  ];
}
