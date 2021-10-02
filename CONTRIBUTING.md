# How to contribute?

## Adding a new scheme
Did you create a scheme? Or perhaps there's a scheme somewhere else you wanna use with nix-colors?

Start, of course, by forking the repository.

Creating a scheme is very simple. Inside `schemes`, create a directory named after your scheme (using snake-case), and create a `scheme-name.yaml` (also snake-case) with this format:

```yaml
# This is a "pretty" name for your scheme, feel free to capitalize
scheme: "Spaceduck"
# Add your name and github/gitlab/sourcehut link, and the original theme creator (if not you)
author: "Guillermo Rodriguez (https://github.com/pineapplegiant), packaged by Gabriel Fontes (https://github.com/Misterio77)"

# These should go from light->dark (for light schemes)
# or dark->light (for dark schemes)
base00: "16172d" # Default background
base01: "1b1c36" # Lighter background (status bars, line numbers)
base02: "30365F" # Selection background
base03: "686f9a" # Comments, Invisibles, Line Highlighting
base04: "818596" # Darker Foreground
base05: "ecf0c1" # Default Foreground
base06: "c1c3cc" # Lighter Foreground
base07: "ffffff" # Lighter Background 
# Please make sure 00 and 05 have nice contrast

# These are the accent colors
# They are usually certain colors, but feel free to go add
# and don't follow these at all!
base08: "e33400" # Red
base09: "e39400" # Orange
base0A: "f2ce00" # Yelow
base0B: "5ccc96" # Green
base0C: "00a3cc" # Cyan
base0D: "7a5ccc" # Blue
base0E: "b3a1e6" # Purple
base0F: "ce6f8f" # Magenta or Brown (not often used)
```

For more information on styling, check [base16's guide](https://github.com/chriskempson/base16/blob/master/styling.md)

If your scheme contains variations (such as dark or light versions), add them on the same directory together.

After you're done with your scheme(s), go to the root of the repo and run `./yaml_to_nix.sh --all` to render the corresponding `.nix` versions.

Commit your changes, and open up a PR!

## Suggestions or misc changes
Feel free to open up a issue or PR if something feels not right, or if you have any questions on how to use this project!
