#!/usr/bin/env nix-shell
#! nix-shell -p nixfmt -i bash
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz

if [ "$1" = "--all" ]; then
    schemes="**/*/*.nix"
else
    schemes="$@"
fi

nixfmt $schemes
