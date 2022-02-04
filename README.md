# Nix Colors

# About
This repo is designed to help with Nix(OS) theming.

The core feature is an attribute set with 220+ base16 themes to be used as you wish.

Plus some other goodies:
- A [home-manager](https://github.com/nix-community/home-manager) module for globally setting your scheme across your configuration
- Lib function for generating a scheme from an image (usually your wallpaper), as well as functions for a few common usecases (generating a wallpaper, vim scheme, gtk theme). These are pretty much "addons", being opinionated but fully optional.

## Base16?
[Base16](https://github.com/chriskempson/base16) is a standard for defining palettes (schemes), and how each app should be themed (templates). For now we'll just hand you the schemes and let you handle how to use each color. I plan on delivering simple base templates as modules soon(tm).

# Setup

The usual setup looks like this:
- Either add the repo to your flake inputs (and pass on `nix-colors` to your home config), or use `fetchTarball` to grab it on a legacy setup.
- Import the home-manager modulemodule `nix-colors.homeManagerModule`
- Set the option `colorscheme` to your preferred color scheme (such as `nix-colors.colorSchemes.dracula`)
- Use `config.colorscheme.colors.base0X` to refer to any of the 16 colors from anywhere!

## Importing

### Flake
First add `nix-colors` to your flake inputs:
```nix
{
  inputs = {
    # ...
    nix-colors.url = "github:misterio77/nix-colors";
  };
}
```

Then, you need some way to pass this onwards to your `home-manager` configuration. You should use `extraSpecialArgs` for this (if you haven't done this before, feel free to ask for my help).

Once you do, you can access the color schemes with `nix-colors.colorSchemes`, and the `home-manager` module with `nix-colors.homeManagerModule`.


### Legacy (non-flake)
If you're not using flakes, just go to the top of your configuration and add:
```
let nix-colors = builtins.fetchTarball "https://github.com/misterio77/nix-colors/archive/main.tar.gz";
```

Now you can access the color schemes with `(import "${nix-colors}/schemes")`, and the `home-manager` module with `(import "${nix-colors}/module")`.

## Using

With that done, move to your home manager configuration.

You should import the `nix-colors.homeManagerModule` (or `(import "${nix-colors}/module")`), and set the option `colorscheme` to your preferred scheme, such as `nix-colors.colorSchemes.dracula` (or `(import "${nix-colors}/schemes").dracula`)

Here's a quick example on how to use it with, say, a terminal emulator (kitty) and a browser (qutebrowser):
```nix
{ pkgs, config, nix-colors, ... }: {
  imports = [
    nix-colors.homeManagerModule
  ];

  colorscheme = nix-colors.colorSchemes.dracula;

  programs = {
    kitty = {
      enable = true;
      settings = {
        foreground = "#${config.colorscheme.colors.base05}";
        background = "#${config.colorscheme.colors.base00}";
        # There's a lot more than just fg and bg...
      };
    };
    qutebrowser = {
      enable = true;
      colors = {
        # Becomes either 'dark' or 'light', based on your colors!
        webppage.preferred_color_scheme = "${config.colorscheme.kind}";
        tabs.bar.bg = "#${config.colorscheme.colors.base00}";
        keyhint.fg = "#${config.colorscheme.colors.base05}";
        # A lot more...
      };
    };
  };
}
```

If you change `colorscheme` for anything else (say, `nix-colors.colorSchemes.nord`), both qutebrowser and kitty will match the new scheme! Awesome!

# Lib functions
[Moved to its own file](lib-usage.md)

# Advanced usage

## Custom scheme
Okay, we have a lot of schemes, but maybe you want to hardcode (or generate it somehow?) your own, no problem! You can just specify it directly:
```nix
{
  colorscheme = {
    slug = "pasque";
    name = "Pasque";
    author = "Gabriel Fontes (https://github.com/Misterio77)";
    colors = {
      base00 = "271C3A";
      base01 = "100323";
      base02 = "3E2D5C";
      base03 = "5D5766";
      base04 = "BEBCBF";
      base05 = "DEDCDF";
      base06 = "EDEAEF";
      base07 = "BBAADD";
      base08 = "A92258";
      base09 = "918889";
      base0A = "804ead";
      base0B = "C6914B";
      base0C = "7263AA";
      base0D = "8E7DC6";
      base0E = "953B9D";
      base0F = "59325C";
    };
  };
}
```

## Listing all schemes (and registry usage)
Maybe you're working on a cool graphical menu for choosing schemes? Or want to pick a random scheme when you press a button?

No problem with `nix-colors`! The fact that we expose all schemes means you can easily use `nix eval` to list schemes (or even grab and print out their colors), for all your scripting needs.
```bash
nix eval --raw nix-colors#colorSchemes --apply 's: builtins.concatStringsSep "\n" (builtins.attrNames s)'
```

This assumes you have nix-colors set as a nix registry. You can easily do it by passing `nix-colors` from your flake to your system configuration, and using:
```nix
{
  nix.registry.nix-colors.flake = nix-colors;
}
```
# Thanks

Special thanks to rycee for most of this repo's inspiration, plus for the amazing home-manager.

Huge thanks for everyone involved with base16.

Extra special thanks for my folks at the NixOS Brasil Telegram group, for willing to try this out!


# Roadmap
- Add support for base24 (which is backwards compatible with base16)
- Add more functions for pre-configured application theming (i'd love your help!)
