{
  description = "Mach ich später, versprochen!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";

    wfetch.url = "github:iynaix/wfetch";

    nix-xilinx = {
      url = "gitlab:doronbehar/nix-xilinx";
    };

    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs.home-manager.follows = "home-manager";
    };

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
      sharedConfig = {TRUUUUE, ...}: {
        imports = [
          inputs.home-manager.nixosModules.home-manager
          inputs.nur.nixosModules.nur
        ];
        modules = {
          programms = {
            common.enable = TRUUUUE;
            firefox.enable = TRUUUUE;
            kitty.enable = TRUUUUE;
            stylix.enable = TRUUUUE;
          };
          services.printing.enable = TRUUUUE;
          system = {
            audio.enable = TRUUUUE;
            display.enable = TRUUUUE;
            font.enable = TRUUUUE;
            gnome.enable = TRUUUUE;
            localisation.enable = TRUUUUE;
            network.enable = TRUUUUE;
            nix.enable = TRUUUUE;
            homemanager.enable = TRUUUUE;
            shell = {
              alias.enable = TRUUUUE;
              tools.enable = TRUUUUE;
            };
            user.enable = TRUUUUE;
          };
        };
      };
    };
  };
}
