{ nixpkgs-lib }:
let
  lib = nixpkgs-lib;
  slugify = import ./slugify.nix { inherit nixpkgs-lib; };

  # All of these are borrowed from nixpkgs
  mapListToAttrs = f: l: lib.listToAttrs (map f l);

  # From https://github.com/arcnmx/nixexprs
  fromYAML = yaml:
    let
      stripLine = line: lib.elemAt (builtins.match "(^[^#]*)($|#.*$)" line) 0;
      usefulLine = line: builtins.match "[ \\t]*" line == null;
      parseString = token:
        let match = builtins.match ''([^"]+|"([^"]*)" *)'' token;
        in if match == null then
          throw ''YAML string parse failed: "${token}"''
        else if lib.elemAt match 1 != null then
          lib.elemAt match 1
        else
          lib.elemAt match 0;
      attrLine = line:
        let match = builtins.match "([^ :]+): *(.*)" line;
        in if match == null then
          throw ''YAML parse failed: "${line}"''
        else
          lib.nameValuePair (lib.elemAt match 0) (parseString (lib.elemAt match 1));
      lines = lib.splitString "\n" yaml;
      lines' = map stripLine lines;
      lines'' = lib.filter usefulLine lines';
    in
    mapListToAttrs attrLine lines'';

  nonNullAttrs = lib.filterAttrs (_: v: v != null);
  convertScheme = set: (nonNullAttrs {
    # Required
    slug = set.slug or (slugify (set.name or set.scheme));
    name = set.name or set.scheme;

    # Optional metadata
    description = set.description or null;
    author = set.author or null;
    variant = set.variant or null;

    # Colors
    palette = set.palette or set.colors or (lib.filterAttrs (n: _: lib.hasPrefix "base" n) set);
  });

  schemeFromYAML = str: convertScheme (fromYAML str);
in
schemeFromYAML
