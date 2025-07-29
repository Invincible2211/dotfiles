{
  description = "Mach ich später, versprochen!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wfetch.url = "github:iynaix/wfetch";

    nix-xilinx = {
      url = "gitlab:doronbehar/nix-xilinx";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };

    image-repo = {
      url = "github:Invincible2211/nix-images";
      flake = false;
    };

    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.home-manager.follows = "home-manager";
    };

    modulix = {
      url = "github:anders130/modulix";
      inputs.nixpkgs.follows = "nixpkgs";
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
        username = "nixuser";
        imagerepo = inputs.image-repo;
      };
      sharedConfig = {...}: {
        imports = [
          inputs.home-manager.nixosModules.home-manager
          inputs.nixvim.nixosModules.nixvim
        ];
        modules = {
          programms = {
            cli = {
                kitty.enable = true;
                nixvim.enable = true;
                docker.enable = true;
            };
            gui = {
                common.enable = true;
                browser = {
                firefox.enable = true;
                };
                theming = {
                stylix.enable = true;
                };
                vm = {
                virtualbox.enable = true;
                };





            };
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
