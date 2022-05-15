# Lib functions usage

Here's a few of our lib functions documented. While nix-colors is unopionionated, the lib functions are designed as (sort of "contrib") opinionated addons for use cases most people would write similar code.

If you're interested in sharing code you wrote for creating stuff from schemes, feel free to open up a PR. As these are optional, the entry barrier is very low.

## Generate a scheme from wallpaper
Simply call `nix-colors.lib` (passing your `pkgs`), and use it like this:

```nix
{ pkgs, config, nix-colors, ... }:

let
  inherit (nix-colors.lib { inherit pkgs; }) colorschemeFromPicture;
in {
  colorscheme = colorschemeFromPicture {
    path = ./wallpapers/example.png;
    kind = "light";
  };
}
```
All done, just use `config.colorscheme` as usual!

## Generate a wallpaper from a scheme
Of course, you can go the other way around too. You can easily use your chosen colorscheme in any sort of derivations.

Our lib function generates a stylish nix-themed wallpaper matching your scheme.
```nix
{ pkgs, config, nix-colors, ... }:

let
  inherit (nix-colors.lib { inherit pkgs; }) nixWallpaperFromScheme;
in {
  colorscheme = nix-colors.colorSchemes.tokyonight;

  wallpaper = nixWallpaperFromScheme {
    scheme = config.colorscheme;
    width = 1920;
    height = 1080;
    logoScale = 4.0;
  };
}
```
This assumes you have an [option named wallpaper](https://github.com/Misterio77/nix-config/blob/7aef57a5a84a176da872665ade96f9ab586474db/modules/home-manager/wallpaper.nix). If so, you can then use `config.wallpaper` wherever you need to you use your wallpaper.

If you don't, just make `wallpaper` a `let` binding instead, or ust use `nixWallpaperFromScheme` directly where it'll be used.

## Generate a GTK theme from a scheme
We also include a lib function for generating a (Materia based, maybe there'll be more options in the future) GTK theme from a scheme.
```nix
{ pkgs, config, nix-colors, ... }:

let
  inherit (nix-colors.lib { inherit pkgs; }) gtkThemeFromScheme;
in {
  colorscheme = nix-colors.colorSchemes.spaceduck;

  gtk.theme = {
    name = "${config.colorscheme.slug}";
    package = gtkThemeFromScheme {
      scheme = config.colorscheme;
    };
  };
}
```

## Vim colorscheme from scheme
We also have a lib function for a (neo)vim colorscheme.

Same as before, call our lib and add the package to `programs.vim.plugins` or `programs.neovim.plugins` like this (the `colorscheme` setting applies it on startup, you can [use neovim remote](https://github.com/Misterio77/nix-config/blob/main/users/misterio/features/cli/nvim/default.nix#L82) to re-source your config when it's updated):
```nix
{ pkgs, config, nix-colors, ... }:

let
  inherit (nix-colors.lib { inherit pkgs; }) vimThemeFromScheme;
in {
  programs.neovim.plugins = [
    {
      plugin = vimThemeFromScheme { scheme = config.colorscheme; };
      config = "colorscheme nix-${config.colorscheme.slug}";
    }
  ];
}
```

## Fish colors from scheme
This lib function generates fish plugin which configures fish colors from a sheme.

```nix
{ pkgs, config, nix-colors, ... }:

let
  inherit (nix-colors.lib { inherit pkgs; }) fishThemeFromScheme;
in {
  programs.fish.plugins = [
    {
      name = "nix-base16";
      src = fishThemeFromScheme { scheme = config.colorscheme; };
    }
  ];
}
```
