{
  description =
    "Collection of nix-compatible color schemes, and a home-manager module to make theming theming easier.";

  outputs = { self }: {
    colorSchemes = import ./schemes;
    homeManagerModule = import ./module;
  };
}
