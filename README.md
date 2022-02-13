# Nix Colors

# About
This repo is designed to help with Nix(OS) theming.

At the core, we have an attribute set with 220+ base16 schemes, as well as a [home-manager](https://github.com/nix-community/home-manager) module for globally setting your preferred one.

Plus some optional [functions](lib-usage.md) for common use cases (generating scheme from image, generating wallpaper, vim scheme, gtk theme).

## Base16?
[Base16](https://github.com/chriskempson/base16) is a standard for defining palettes (schemes), and how each app should be themed (templates). nix-colors focuses on delivering you the schemes, with their usage being easy, flexible, and unopinionated (you can set options to them, generate derivations from them, anything really). For a few more complex use cases, we also have opinionated functions, which are fully optional.

## Existing solutions?
Nix is amazing and lets people do stuff their way, so people end up with lots of different (often incompatible) solutions to the same problem.

Theming is one of them. Based on [rycee's](https://gitlab.com/rycee/nur-expressions/-/tree/master/hm-modules/theme-base16), some of my experience with creating a [base16 theming workflow](https://github.com/misterio77/flavours), and a demand for a easy way to expose multiple schemes, i decided to create this.

Perhaps this could become a standard solution for a common problem.

![relevant xkcd](https://imgs.xkcd.com/comics/standards.png)

# Setup

The usual setup looks like this:
- Either add the repo to your flake inputs, or add the channel on a legacy setup.
- Import the home-manager module `nix-colors.homeManagerModule`
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

Then, you need some way to pass this onwards to your `home-manager` configuration.

If you're using standalone home-manager, use `extraSpecialArgs` for this:
```nix
homeConfigurations = {
  "foo@bar" = home-manager.lib.homeManagerConfiguration {
    # ...
    extraSpecialArgs = { inherit nix-colors; };
  };
};
```

Or, if using it as a NixOS module, use `specialArgs` on your flake (and `extraSpecialArgs` wherever you import your home nix file):
```nix
nixosConfigurations = {
  bar = nixpkgs.lib.nixosSystem {
    # ...
    specialArgs = { inherit nix-colors; };
  };
};
```


### Legacy (non-flake)
If you're not using flakes, the most convenient method is adding nix-colors to your channels:
```
nix-channel --add https://github.com/misterio77/nix-colors/archive/main.tar.gz nix-colors
nix-channel --update
```

Then, at the top of your config file(s) add `nix-colors ? <nix-colors>` as an argument (instead of just `nix-colors`).

## Using

With that done, move on to your home manager configuration.

You should import the `nix-colors.homeManagerModule`, and set the option `colorscheme` to your preferred scheme, such as `nix-colors.colorSchemes.dracula`

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
        # ...
      };
    };
    qutebrowser = {
      enable = true;
      colors = {
        # Becomes either 'dark' or 'light', based on your colors!
        webppage.preferred_color_scheme = "${config.colorscheme.kind}";
        tabs.bar.bg = "#${config.colorscheme.colors.base00}";
        keyhint.fg = "#${config.colorscheme.colors.base05}";
        # ...
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

It is quite nice to add all your flake inputs as system registries, [here's an example on how to do it](https://github.com/Misterio77/nix-starter-config/blob/minimal/configuration.nix#L67).

# Thanks

Special thanks to rycee for most of this repo's inspiration, plus for the amazing home-manager.

Huge thanks for everyone involved with base16.

Extra special thanks for my folks at the NixOS Brasil Telegram group, for willing to try this out!


# Roadmap
- Add support for base24 (which is backwards compatible with base16)
- Add more functions for pre-configured application theming (i'd love your help!)
