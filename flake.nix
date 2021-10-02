{
  description = "Collection of modules to make theming with Nix easier, includes curated base16 schemes.";

  outputs = { self }: {
    colorSchemes = import ./schemes;
    homeManagerModules = import ./modules;
  };
}
