# Lib functions usage

Here's a few of our lib functions documented. They're designed to be optional convenience for some common scheme usage.

## Generate a scheme from wallpaper
You can easily use a derivation to generate a scheme from anything, including a picture.

As it's a common usecase, we include a lib function to do just that. Simply call `nix-colors.lib` (passing your pkgs attribute), and it's at your disposal:
```nix
{ pkgs, config, nix-colors, ... }:

with nix-colors.lib { inherit pkgs; };
{
  colorscheme = colorschemeFromPicture {
    path = ./wallpapers/example.png;
    kind = "light";
  };
}
```
All done, just use `config.colorscheme` as usual!

### Generate a wallpaper from a scheme
Of course, you can go the other way around too. You can easily use your chosen colorscheme in any sort of derivations.

We include a lib function for generating a stylish nix-themed wallpaper matching your scheme.
```nix
{ pkgs, config, nix-colors, ... }:

with nix-colors.lib { inherit pkgs; };
{
  colorscheme = nix-colors.colorSchemes.tokyonight;

  wallpaper = nixWallpaperFromScheme {
    scheme = config.colorscheme;
    width = 1920;
    height = 1080;
    logoScale = 4.0;
  };
}
```
This assumes you have an [option named wallpaper](https://github.com/Misterio77/nix-config/blob/7aef57a5a84a176da872665ade96f9ab586474db/modules/home-manager/wallpaper.nix), of course. If so, you can then use `config.wallpaper` wherever you need to you use your wallpaper.

If you don't, just make `wallpaper` a `let` binding instead, or ust use `nixWallpaperFromScheme` directly where it'll be used.

[Here's example usage](https://github.com/Misterio77/nix-config/blob/3d2da71578b930ea065a61a73fc26155482ab438/users/misterio/rice.nix) for both this and scheme generation.

### Generate a GTK theme from a scheme
We also include a lib function for generating a (Materia based, maybe more options in the future) GTK (plus gnome shell and cinnamon) theme from a scheme.

Just call our lib same as above, and use `gtkThemeFromScheme`:

```nix
{ pkgs, config, nix-colors, ... }:

with nix-colors.lib { inherit pkgs; };
{
  colorscheme = nix-colors.colorSchemes.spaceduck;

  gtk.theme = {
    name = "${config.colorscheme.slug}";
    package = gtkThemeFromScheme {
      scheme = config.colorscheme;
    };
  };
}
```

### Vim colorscheme from scheme
We also have a lib function for a (neo)vim colorscheme.

Same as before, call our lib and add the package to `programs.vim.plugins` or `programs.neovim.plugins` (optionally, add `colorscheme nix-${slug}` to your config so the colorscheme applies on startup):
```nix
{ pkgs, config, nix-colors, ... }:

with nix-colors.lib { inherit pkgs; };

{
  programs.neovim.plugins = [
    {
      plugin = vimThemeFromScheme { scheme = config.colorscheme; };
      config = "colorscheme nix-${config.colorscheme.slug}";
    }
  ];
}
```

