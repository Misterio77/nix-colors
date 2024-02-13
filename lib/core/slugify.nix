{ nixpkgs-lib }: let
  lib = nixpkgs-lib;

  filterChars = f: str: lib.concatStrings (lib.filter f (lib.stringToCharacters str));

  validChars = lib.stringToCharacters "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890-";
  isValid = x: lib.elem x validChars;

  slugify = str: lib.toLower (filterChars isValid (lib.replaceStrings [" "] ["-"] str));
in slugify
