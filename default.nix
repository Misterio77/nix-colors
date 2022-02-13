rec {
  lib = import ./lib;
  colorSchemes = import ./schemes;
  homeManagerModules.colorscheme = import ./module;
  homeManagerModule = homeManagerModules.colorscheme;
}
