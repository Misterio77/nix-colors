# Nix Colors

# What?
This repo is designed to help with Nix(OS) theming, exposing a nix attribute set with 204+ themes to be used as you wish. As well as a [home-manager](https://github.com/nix-community/home-manager) module you can import to globally set your scheme across your entire configuration.

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
While i appreciate their work, more maintainers are needed to keep up with PRs and improvements, and base16's creator (and [only one that can add more maintainers or move the repo to an org](https://github.com/chriskempson/base16/issues/74)) has no github activity over the last two years.

This repo aims to help with that. By keeping all scheme definitions in one place, we can easily track additions and QA all added schemes, while weeding out low-quality ones.

We include most (if not all) of base16 schemes, including some PRs that are still waiting to be merged. Any contribution there should find its way here soon after.

---

# How?

Please keep in mind this repo is WIP and its interface is subject to change (probably won't, but no guarantees). I suggest you either use flakes for reproductibility or pin your fetchurl incantation.

## TL;DR

The general idea is:
- Either add the repo to your flake inputs (and pass on `nix-colors` to your home config), or use `fetchTarball` to grab it on a legacy setup.
- Import the module `nix-colors.homeConfigurationModule`
- Set the option `nix-colors.colorscheme` to your preferred color scheme (such as `nix-colors.colorSchemes.dracula`)
- Use `config.nix-colors.colorscheme.colors.base0X` to refer to any of the 16 colors from anywhere!

## Walkthrough

### Importing

#### Flake
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


#### Legacy (non-flake)
If you're not using flakes, just go to the top of your configuration and add:
```
let nix-colors = builtins.fetchTarball "https://github.com/misterio77/nix-colors/archive/main.tar.gz";
```

Now you can access the color schemes with `(import "${nix-colors}/schemes")`, and the `home-manager` module with `(import "${nix-colors}/module")`.

### Using

With that done, move to your home manager configuration.

You should import the `nix-colors.homeManagerModule` (or `(import "${nix-colors}/module")`), and set the option `nix-colors.colorscheme` to your preferred scheme, such as `nix-colors.colorSchemes.dracula` (or `(import "${nix-colors}/schemes").dracula`)

Here's a quick example on how to use it with, say, a terminal emulator (kitty) and a browser (qutebrowser):
```nix
{ pkgs, config, nix-colors, ... }: {
  imports = [
    nix-colors.homeManagerModule
  ];

  nix-colors.colorscheme = nix-colors.colorSchemes.dracula;

  programs = let colorscheme = config.nix-colors.colorscheme; in {
    kitty = {
      enable = true;
      settings = {
        foreground = "#${colorscheme.colors.base05}";
        background = "#${colorscheme.colors.base00}";
        # There's a lot more than just fg and bg...
      };
    };
    qutebrowser = {
      enable = true;
      colors = {
        # Becomes either 'dark' or 'light', based on your colors!
        webppage.preferred_color_scheme = "${colorscheme.kind}";
        tabs.bar.bg = "#${colorscheme.colors.base00}";
        keyhint.fg = "#${colorscheme.colors.base05}";
        # A lot more...
      };
    };
  };
}
```

If you change `nix-colors.colorscheme` for anything else (say, `nix-colors.colorSchemes.nord`), both qutebrowser and kitty will match the new scheme! Awesome!

### Tips and tricks

#### Custom scheme
Okay, we have 200+ themes, but maybe you want to hardcode your own (or somehow dynamically generate it), no problem! You can just specify it directly:
```nix
{
  nix-colors.colorscheme = {
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

#### Listing all schemes (and registry use)
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

#### Generate a scheme from wallpaper
You can easily create a shell script to generate a scheme you can use here!

This repo includes a ready to use script (`scripts/generate_from_wallpaper.sh`, pass your wallpaper file and "dark" or "light" as arguments) for that, that uses [flavours](https://github.com/misterio77/flavours). But you can do it with pywal or any other generator.

Pipe the output to a `.nix` file, aand then just set your `nix-colors.colorscheme` like so:

```bash
scripts/generate_from_wallpaper.sh /path/to/cool/wallpaper.png dark > /path/to/your/output.nix
```

```nix
{
  nix-colors.colorscheme = (import /path/to/your/output.nix);
}
```

# Thanks

Special thanks to rycee for most of this repo's inspiration, plus for the amazing home-manager.

Huge thanks for everyone involved with base16.

And extra special thanks for my folks at the NixOS Brasil Telegram group, for willing to try this out!


# Roadmap
- Add support for base24 (which is backwards compatible with both base16 schemes and templates)
- Add modules for pre-configured application theming
- ???
