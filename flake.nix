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

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };

    image-repo = {
      url = "github:Invincible2211/nix-images";
      flake = false;
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
        imagerepo = inputs.image-repo;
      };
      sharedConfig = {...}: {
        imports = [
          inputs.home-manager.nixosModules.home-manager
          inputs.nur.nixosModules.nur
          inputs.nixvim.nixosModules.nixvim
        ];
        modules = {
          programms = {
            common.enable = true;
            firefox.enable = true;
            kitty.enable = true;
            stylix.enable = true;
            nixvim.enable = true;
	    docker.enable = true;
          };
          services.printing.enable = true;
          system = {
	    kernel.enable = true;
            audio.enable = true;
            display.enable = true;
            font.enable = true;
            gnome.enable = true;
            localisation.enable = true;
            network.enable = true;
            nix.enable = true;
            homemanager.enable = true;
            shell = {
              alias.enable = true;
              tools.enable = true;
            };
            user.enable = true;
          };
        };
      };
    };
  };
}
