{
  username,
  pkgs,
  lib,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = lib.capitalized username;
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
    ];
  };
}
