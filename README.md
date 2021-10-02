# Nix Colors

# What?
This repo is designed to help with Nix(OS) theming, employing easily importable nix attribute sets to be used as color schemes in your [home-manager](https://github.com/nix-community/home-manager) configuration.

It fills pretty much the same usecase of my project [flavours](https://github.com/misterio77/flavours), but for your cool reproductible Nix configurations!

## What is base16?
[Base16](https://github.com/chriskempson/base16) is a standard for defining palettes (schemes), and how each app should be themed (templates). For now we'll just hand you the schemes and let you handle how to use each color. I plan on delivering simple templates as modules soon(tm).

---

# Why?

## Existing solutions?
Nix is amazing and lets people do stuff their way, but we are often missing a standardized way of doing something, so people end up with lots of different (often incompatible) solutions to the same problem. Probably buried inside their dotfiles or NUR repositories.

Theming is one of them. Based on [rycee's](https://gitlab.com/rycee/nur-expressions/-/tree/master/hm-modules/theme-base16), some of my experience with creating a [base16 theming workflow](https://github.com/misterio77/flavours), and a demand for a easy way to expose multiple schemes, i decided to create this.

Perhaps this could become a standard solution for a common problem.

![relevant xkcd](https://imgs.xkcd.com/comics/standards.png)

## Why not use base16 listings?
I absolutely love base16, but it's messy. The repos are very fragmented and make difficult to QA and aggregate all the schemes and templates.
While i appreciate their work, the maintainers are the bottleneck and are often missing.

This repo aims to help with that. By keeping all scheme definitions in one place, we can easily track additions and QA all added schemes, while weeding out low-quality ones.

---

# How?

Please keep in mind this repo is WIP and is subject to change. I suggest you either use flakes or pin your fetchurl incantation.

## TL;DR

The general idea is:
- Either add the repo to your flake inputs, or use `fetchTarball` to grab it on a legacy setup.
- Pass `nix-colors` on to your home configuration
- Import the module `nix-colors.homeConfigurationModule`
- Set the option `nix-colors.colorscheme` to your preferred color scheme (such as `nix-colors.colorScheme.dracula`)
- Use `config.nix-colors.colorscheme.colors.base0X` to refer to any of the 16 colors from anywhere!

## Walkthrough

### Importing

#### Flake
First add `nix-colors` to your flake inputs:
```nix
inputs = {
  # ...
  nix-colors.url = "github:misterio77/nix-colors";
};
```

Then, you need some way to pass this onwards to your `home-manager` configuration. You should use `extraSpecialArgs` for this (if you haven't done this before, feel free to ask for my help).

Once you you do, you can access the color schemes with `nix-colors.colorSchemes`, and the `home-manager` module with `nix-colors.homeManagerModule`.


#### Legacy (non-flake)
If you're not using flakes, just go to the top of your configuration and add:
```
let nix-colors = builtins.fetchTarball "https://github.com/misterio77/nix-colors/archive/main.tar.gz";
```

Now you can access the color schemes with `(import "${nix-colors}/schemes")`, and the `home-manager` module with `(import "${nix-colors}/module")`.

### Using

With that done, move to your home manager configuration.

You should import the `nix-colors.homeManagerModule` (or `(import "${nix-colors}/module")`), and set the option `nix-colors.colorscheme` to your preferred scheme, such as `nix-colors.colorScheme.dracula` (or `(import "${nix-colors}/schemes").dracula`)

Here's a quick example on how to use it with, say, a terminal emulator (kitty):
```nix
{ pkgs, config, nix-colors, ... }: {
  imports = [
    nix-colors.homeManagerModule
  ];

  nix-colors.colorscheme = nix-colors.colorSchemes.dracula;

  programs.kitty = {
    enable = true;
    settings = let colors = config.nix-colors.colorscheme.colors; in {
      foreground = "#${colors.base05}";
      background = "#${colors.base00}";
      # There's a lot more than just fg and bg...
    };
  };
}
```

# Thanks

Special thanks to rycee for most of this repo's inspiration, plus for the amazing home-manager.

Huge thanks for everyone involved with base16.

And extra special thanks for my folks at the NixOS Brasil Telegram group, for willing to try this out!
