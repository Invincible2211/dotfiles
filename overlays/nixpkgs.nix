inputs: final: prev: let
    unstable = import inputs.nixpkgs-unstable {
        inherit (prev) config system;
    };
    # Apply zenix overlay to get zen-browser package
    zenixOverlay = inputs.zenix.overlays.default final prev;
in {
        inherit (unstable) citrix_workspace;
        inherit (zenixOverlay) zen-browser;
}