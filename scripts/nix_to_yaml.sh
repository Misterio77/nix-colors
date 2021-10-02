#!/usr/bin/env nix-shell
#! nix-shell -p nixUnstable -p yq-go -p jq -i bash
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz

nix eval --raw --impure --expr "builtins.toJSON $(tee)" | yq eval '.. style="double"' <( jq '{name: .name, author: .author} * .colors' )
