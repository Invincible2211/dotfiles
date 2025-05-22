{
  username,
  pkgs,
  lib,
  ...
}: {
  users.users.${username} = {
    isNormalUser = true;
    description = lib.capitalized username;
    extraGroups = ["networkmanager" "wheel"];
    hashedPassword = "$y$j9T$gCOwXf/LgEYuKz0W/JX9B0$YG21RcSfIk4e29NxYAo4hRAMRcfPOmgmUn5mINLvg8C";
  };
}
