let
  inherit (builtins.fromJSON (builtins.readFile ./flake.lock)) nodes;
  # Fetch using flake lock, for legacy compat
  fromFlake = name:
    let inherit (nodes.${name}) locked;
    in fetchTarball {
      url =
        "https://github.com/${locked.owner}/${locked.repo}/archive/${locked.rev}.tar.gz";
      sha256 = locked.narHash;
    };

in
{ nixpkgs-lib ? import ((fromFlake "nixpkgs-lib") + "/lib")
, base16-schemes ? fromFlake "base16-schemes"
, ...
}: rec {
  lib-contrib = import ./lib/contrib;
  lib-core = import ./lib/core { inherit nixpkgs-lib; };
  lib = lib-core // { contrib = lib-contrib; };

  tests = import ./lib/core/tests { inherit nixpkgs-lib; };

  colorSchemes = import ./schemes.nix { inherit lib base16-schemes; };
  # Alias
  colorschemes = colorSchemes;

  homeManagerModules = rec {
    colorScheme = import ./module;
    # Alias
    colorscheme = colorScheme;
    default = colorScheme;
  };
  homeManagerModule = homeManagerModules.colorScheme;
}
