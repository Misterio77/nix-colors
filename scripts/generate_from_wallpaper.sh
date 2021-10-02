#!/usr/bin/env nix-shell
#! nix-shell -p flavours -i bash
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz

if [ -z "$1" ]; then
    &>2 echo "You must specify a wallpaper path"
    exit 1
else
    wallpaper_path="$1"
fi

if [ -z "$2" ]; then
    mode="dark"
else
    mode="$2"
fi

wallpaper_basename="$(basename "$wallpaper_path")"

read -r -d '' template << END
{
  slug = "generated-$wallpaper_basename"
  name = "Generated ($wallpaper_basename)";
  author = "{{scheme-author}}";
  colors = {
    base00 = "{{base00-hex}}";
    base01 = "{{base01-hex}}";
    base02 = "{{base02-hex}}";
    base03 = "{{base03-hex}}";
    base04 = "{{base04-hex}}";
    base05 = "{{base05-hex}}";
    base06 = "{{base06-hex}}";
    base07 = "{{base07-hex}}";
    base08 = "{{base08-hex}}";
    base09 = "{{base09-hex}}";
    base0A = "{{base0A-hex}}";
    base0B = "{{base0B-hex}}";
    base0C = "{{base0C-hex}}";
    base0D = "{{base0D-hex}}";
    base0E = "{{base0E-hex}}";
    base0F = "{{base0F-hex}}";
  };
}
END

flavours generate "$mode" "$wallpaper_path" --stdout | \
flavours build <( tee ) <( echo "$template" )
