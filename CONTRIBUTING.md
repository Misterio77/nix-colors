# How to contribute?

## Adding a new scheme
Did you create a scheme? Or perhaps there's a scheme somewhere else you wanna use with nix-colors?

**Note**: This repo is licensed under GPL, but each scheme has its own license. Only contribute schemes that are either freely licensed (GPL-compatible), or you created yourself.

Start, of course, by forking the repository.

Creating a scheme is very simple. Inside `schemes`, create a directory named after your scheme (using snake-case), and create a `scheme-name.nix` (also snake-case) with this format:

```nix
{
  # This should be exactly the same as the filename, without the .nix. snake-case.
  slug = "spaceduck";
  # This is a "pretty" name for your scheme, feel free to capitalize
  name = "Spaceduck";
  # Fill in your name and github/gitlab/sourcehut link, and the original theme creator's (if not you)
  author =
    "Guillermo Rodriguez (https://github.com/pineapplegiant), packaged by Gabriel Fontes (https://github.com/Misterio77)";
  colors = {
    # These should go from light->dark (for light schemes)
    # or dark->light (for dark schemes)
    base00 = "16172d"; # Default background
    base01 = "1b1c36"; # Lighter background (status bars, line numbers)
    base02 = "30365F"; # Selection background
    base03 = "686f9a"; # Comments, Invisibles, Line Highlighting
    base04 = "818596"; # Darker Foreground
    base05 = "ecf0c1"; # Default Foreground
    base06 = "c1c3cc"; # Lighter Foreground
    base07 = "ffffff"; # Lighter Background

    # These are the accent colors.
    # They usually follow a standard, but feel free to just go wild
    # and use whatever colors you want, that better fit the style
    base08 = "e33400"; # Red
    base09 = "e39400"; # Orange
    base0A = "f2ce00"; # Yelow
    base0B = "5ccc96"; # Green
    base0C = "00a3cc"; # Cyan
    base0D = "7a5ccc"; # Blue
    base0E = "b3a1e6"; # Purple
    base0F = "ce6f8f"; # Magenta or Brown (not often used)
  };
}
```

For more information on styling, check [base16's guide](https://github.com/chriskempson/base16/blob/master/styling.md)

If your scheme contains variations (such as dark or light versions), add them on the same directory together.

Ensure your `.nix` files are `nixfmt`ted (you can run `./scripts/nixfmt.sh --all`).

Commit your changes, and open up a PR!

**PS**: If you wanna contribute this scheme to the [base16](https://github.com/chriskempson/base16) too, we have a script for that. Just run `./scripts/nix_to_yaml.sh < scheme-file.nix`, and it will be output to your stdout. You can also go the way back (maybe convert an existing yaml theme to nix), using `./scripts/yaml_to_nix.sh < scheme-file.yaml` (in this case you'll have to manually add in the slug)

## Suggestions or misc changes
Feel free to open up a issue or PR if something feels not right, or if you have any questions on how to use this project!
