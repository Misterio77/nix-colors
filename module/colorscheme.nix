{ lib, config, ... }:

with lib;
let
  cfg = config.colorScheme;
  hexColorType = mkOptionType {
    name = "hex-color";
    description = "RGB color in hex format, excluding leading #";
    check = with types; (x:
      (isString x) &&
      (stringLength x == 6) &&
      !(hasPrefix "#" x)
    );
  };
in
{
  imports = [ (mkAliasOptionModule [ "colorscheme" ] [ "colorScheme" ]) ];

  options.colorScheme = {
    slug = mkOption {
      type = types.str;
      example = "awesome-scheme";
      description = ''
        Color scheme slug (sanitized name)
      '';
    };
    name = mkOption {
      type = types.str;
      default = "";
      example = "Awesome Scheme";
      description = ''
        Color scheme (pretty) name
      '';
    };
    author = mkOption {
      type = types.str;
      default = "";
      example = "Gabriel Fontes (https://m7.rs)";
      description = ''
        Color scheme author
      '';
    };
    kind = mkOption {
      type = types.enum [ "dark" "light" ];
      default =
        if builtins.substring 0 1 cfg.colors.base00 < "5" then
          "dark"
        else
          "light";
      description = ''
        Whether the scheme is dark or light
      '';
    };

    colors = mkOption {
      type = types.attrsOf hexColorType;
      default = { };
      example = literalExpression ''
        {
          base00 = "002635";
          base01 = "00384d";
          base02 = "517F8D";
          base03 = "6C8B91";
          base04 = "869696";
          base05 = "a1a19a";
          base06 = "e6e6dc";
          base07 = "fafaf8";
          base08 = "ff5a67";
          base09 = "f08e48";
          base0A = "ffcc1b";
          base0B = "7fc06e";
          base0C = "14747e";
          base0D = "5dd7b9";
          base0E = "9a70a4";
          base0F = "c43060";
        }
      '';
      description = ''
        Atribute set of hex colors (excluding leading #).

        These are usually base00-base0F, but you may use any name you want.
        This allows you to create arbitrarily named colors, similarly to
        base17/basenext. You may also use base24 colors, for example.

        The colorschemes provided by nix-colors follow the base16 standard.
        Some might leverage base24 and have 24 colors, but these can be safely
        used as if they were base16.
      '';
    };
  };
}
