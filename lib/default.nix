# Lib was used in the past for contrib functions, which requires pkgs, so this
# can't be converted from a function returning attrset to just a regular
# attrset without a confusing error for users.

# Thus, this is kept for giving a friendlier error. Maybe core lib will move
# here, eventually, after we've given enough time for people to migrate.
{ ... }:
throw ''
  Opinionated nix-colors functions have been moved from `nix-colors.lib` into `nix-colors.lib-contrib`.
  Please update your `nix-colors.lib { inherit pkgs; }` calls to `nix-colors.lib-contrib { inherit pkgs; }`.''
