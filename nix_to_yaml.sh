#!/usr/bin/env nix-shell
#! nix-shell -p nixUnstable -p yq-go -p jq -i bash
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz

for scheme in $@; do
    nix eval --raw --impure --expr "builtins.toJSON (import ./${scheme})" | yq eval '.. style="double"' <( jq '{name: .name, author: .author} * .colors' )
done
