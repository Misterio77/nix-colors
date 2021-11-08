#!/usr/bin/env nix-shell
#! nix-shell -p nixfmt -p flavours -i bash
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz

set -eu

# Path of one directory above the scripts (that is, the repository root)
base_dir="$(dirname $(realpath $0))/.."

yaml_to_nix() {
template_contents=$( cat <<-END
{
  slug = "$1";
  name = "{{scheme-name}}";
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
)

flavours build <( tee ) <( echo "$template_contents" ) | nixfmt
}

pull_scheme() {
    cd "$base_dir"/schemes

    if [ -z "$1" ] || [[ "$1" == \#* ]]; then
        return
    fi

    scheme_dir=$(echo "$1" | cut -d ':' -f 1 | xargs)
    scheme_repo=$(echo "$1" | cut -d ':' -f 2- | xargs)

    rm "$scheme_dir" -rf 2> /dev/null || true
    git clone "$scheme_repo" "$scheme_dir" || return
    cd "$scheme_dir" || return

    rm -rf .git || true
    license="$(cat *{COPYING,LICENSE,copying,license}{.md,} 2> /dev/null || true)"
    rm {COPYING,LICENSE}{.md,} 2>/dev/null || true
    if [ -z "$license" ]; then
        license="No license was provided"
    fi

    echo "This scheme was packaged for base16 on: $scheme_repo" > LICENSE
    echo "==" >> LICENSE
    echo "$license" >> LICENSE

    find . -mindepth 1 -maxdepth 1 -name "*.yaml" -or -name "*.yml" | \
    while read -r scheme_file; do
        scheme_slug=$(basename "$scheme_file" | cut -d '.' -f1)
        if [ "$scheme_slug" = "base16-vice-scheme" ]; then
            scheme_slug="vice"
        fi
        cat "$scheme_file" | yaml_to_nix "$scheme_slug" > "$scheme_slug.nix"
    done

    find . -mindepth 1 ! \( -name 'LICENSE' -o -name "*.nix" \) -delete
}

while read -r scheme; do
    pull_scheme "$scheme" & \
done

wait $(jobs -p)
