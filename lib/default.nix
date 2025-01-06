inputs: let
  lib = inputs.nixpkgs.lib;
in {
  importFromDir = import ./importFromDir {};
  capitalized = import ./strings {inherit lib;};
}
