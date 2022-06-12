{
  description =
    "Collection of nix-compatible color schemes, and a home-manager module to make theming easier.";

  inputs = {
    # Upstream source of .yaml base16 schemes
    base16-schemes.url = "github:base16-project/base16-schemes";
    base16-schemes.flake = false;
  };

  outputs = { self, base16-schemes }:
    import ./. { base16-schemes = base16-schemes.outPath; };
}
