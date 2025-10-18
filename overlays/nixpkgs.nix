# Central overlay combining all package sources
# This overlay is automatically applied to all hosts via sharedConfig
inputs: final: prev: let
    # Import unstable nixpkgs for newer packages
    unstable = import inputs.nixpkgs-unstable {
        inherit (prev) config system;
    };

    # Apply zenix overlay for zen-browser
    zenixOverlay = inputs.zenix.overlays.default final prev;
in {
    # Packages from unstable channel
    inherit (unstable) citrix_workspace;

    # Packages from external overlays
    inherit (zenixOverlay) zen-browser;

    # Packages from flake inputs
    wfetch = inputs.wfetch.packages.${prev.system}.default;
}