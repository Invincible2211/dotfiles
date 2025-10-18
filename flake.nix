{
  description = "Mach ich später, versprochen!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wfetch.url = "github:iynaix/wfetch";

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
    };

    zenix = {
      url = "github:anders130/zenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    modulix = {
      url = "github:anders130/modulix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs: {
    overlays = {
        nixpkgs = import ./overlays/nixpkgs.nix inputs;
    };
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
        # Apply zenix overlay for zen-browser package
        nixpkgs.overlays = [inputs.zenix.overlays.default];
      };
    };
  };
}
