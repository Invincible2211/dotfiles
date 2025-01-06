{
  username,
  pkgs,
  lib,
  ...
}: {
  home-manager = {
    users.${username}.home = {
      stateVersion = "24.05";
      inherit username;
      homeDirectory = "/home/${username}";
    };
    backupFileExtension = "hmbak";
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = lib.capitalized username;
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
    ];
  };
}
