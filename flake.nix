{
  description = "Collection of modules to make theming with Nix easier, includes curated base16/24 schemes.";

  outputs = { ... }: {
    colorSchemes = import ./colors.nix;
  };
}
