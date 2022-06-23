{
  description = "Collection of nix-compatible color schemes, and a home-manager module to make theming easier.";

  inputs = {
    nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";

    # Upstream source of .yaml base16 schemes
    base16-schemes.url = "github:base16-project/base16-schemes";
    base16-schemes.flake = false;
  };

  outputs = {
    self,
    nixpkgs-lib,
    base16-schemes,
  }:
    import ./. {
      inherit nixpkgs-lib;
      base16-schemes = base16-schemes.outPath;
    };
}
