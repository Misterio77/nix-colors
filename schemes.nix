{ lib, tt-schemes, nixpkgs-lib, ... }:
let
  inherit (nixpkgs-lib)
    readFile attrNames listToAttrs filter hasSuffix;
  inherit (lib) schemeFromYAML;

  isYaml = filename: (hasSuffix ".yml" filename) || (hasSuffix ".yaml" filename);

  colorSchemeFiles = filter isYaml (attrNames (builtins.readDir "${tt-schemes}/base16"));
  colorSchemeList = map (file: schemeFromYAML (readFile "${tt-schemes}/base16/${file}")) colorSchemeFiles;

  colorSchemes = listToAttrs (map (scheme: {
    name = scheme.slug;
    value = scheme;
  }) colorSchemeList);
in
colorSchemes
