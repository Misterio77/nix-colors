{nixpkgs-lib}: let
  inherit (nixpkgs-lib) callPackage;
in {
  math = callPackage ./math.nix;
  conversions = callPackage ./conversions.nix;
}
