inputs: let
  lib = inputs.nixpkgs.lib.extend (final: prev: import ../lib {lib = prev;});

  mkNixosConfig = {
    name,
    hostname,
    username,
    system ? "x86_64-linux",
  }: let
    specialArgs = {
      inherit name username hostname lib;
    };
  in
    inputs.nixpkgs.lib.nixosSystem {
      inherit system specialArgs;
      modules = [
        ../modules
        ./${name}
        ./${name}/hardware-configuration.nix
        inputs.home-manager.nixosModules.home-manager
        inputs.nur.nixosModules.nur
      ];
    };
in {
  Yozora = mkNixosConfig {
    name = "Yozora";
    hostname = "Yozora";
    username = "hoshi";
  };
}
