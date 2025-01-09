{
  description = "Mach ich später, versprochen!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";

    modulix = {
      url = "github:anders130/modulix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs: {
    formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;
    nixosConfigurations = inputs.modulix.lib.mkHosts {
      inherit inputs;
      flakePath = "/home/hoshi/dotfiles";
      modulesPath = ./modules;
      helpers = import ./lib inputs;
      specialArgs = {
        hostname = "nixos";
        TRUUUUE = true;
      };
      sharedConfig = {
        imports = [
          inputs.home-manager.nixosModules.home-manager
          inputs.nur.nixosModules.nur
        ];
        modules = {
          programms = {
            common.enable = true;
            firefox.enable = true;
            kitty.enable = true;
          };
          services.printing.enable = true;
          system = {
            audio.enable = true;
            display.enable = true;
            font.enable = true;
            gnome.enable = true;
            localisation.enable = true;
            network.enable = true;
            nix.enable = true;
            shell = {
              alias.enable = true;
              tools.enable= true;
            };
            user.enable = true;
          };
        };
      };
    };
  };
}
