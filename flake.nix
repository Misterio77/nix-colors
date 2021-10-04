{
  description =
    "Collection of nix-compatible color schemes, and a home-manager module to make theming easier.";

  outputs = { self }: {
    lib = import ./lib;
    colorSchemes = import ./schemes;
    homeManagerModules.colorscheme = import ./module;
    homeManagerModule = self.homeManagerModules.colorscheme;
  };
}
