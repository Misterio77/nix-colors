let
  inherit (builtins) concatStringsSep map;

  # From nixpkgs, but with newline
  concatMapStrings = f: list: concatStringsSep "\n" (map f list);

  colorNames = map (n: "base0${n}")
    [ "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "A" "B" "C" "D" "E" "F" ];

  schemeToYAML = scheme: ''
    scheme: "${scheme.name}"
    author: "${scheme.author}"
  '' + concatMapStrings # Add a line for each base0X color
    (color: ''${color}: "${scheme.colors.${color}}"'')
    colorNames;
in
schemeToYAML
