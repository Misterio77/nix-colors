{
  description =
    "Collection of nix-compatible color schemes, and a home-manager module to make theming easier.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Upstream source of .yaml base16 schemes
    base16-schemes.url = "github:base16-project/base16-schemes";
    base16-schemes.flake = false;
  };

  outputs = { self, nixpkgs, base16-schemes }:
    import ./. { inherit nixpkgs; base16-schemes = base16-schemes.outPath; };
}
