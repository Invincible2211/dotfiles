inputs: final: prev: let
    unstable = import inputs.nixpkgs-unstable {
        inherit (prev) config system;
    };
in {
        inherit (unstable) citrix_workspace;
}