{
  description =
    "Collection of nix-compatible color schemes, and a home-manager module to make theming easier.";

  inputs = {
    nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";

    # Upstream source of .yaml base16 schemes
    tt-schemes.url = "github:tinted-theming/schemes";
    tt-schemes.flake = false;
  };

  outputs = { self, nixpkgs-lib, tt-schemes }:
    import ./. {
      nixpkgs-lib = nixpkgs-lib.lib;
      tt-schemes = tt-schemes.outPath;
    };
}
