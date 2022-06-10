{ base16-schemes ? # If not defined (when not using flakes), download with fetchTarball (by lockfile info)
  let
    inherit (builtins) fromJSON readFile;
    inherit ((fromJSON (readFile ./flake.lock)).nodes.base16-schemes) locked;
  in
  fetchTarball {
    url = "https://github.com/${locked.owner}/${locked.repo}/archive/${locked.rev}.tar.gz";
    sha256 = locked.narHash;
  }
, ...
}:
rec {
  lib = import ./lib;
  lib-contrib = import ./lib/contrib;
  lib-core = import ./lib/core;

  colorSchemes = import ./schemes.nix { inherit lib-core base16-schemes; };

  homeManagerModules = rec {
    colorScheme = import ./module;
    # Aliases
    colorscheme = colorScheme;
    default = colorScheme;
  };
  # Deprecated alias
  homeManagerModule = homeManagerModules.colorscheme;
}
