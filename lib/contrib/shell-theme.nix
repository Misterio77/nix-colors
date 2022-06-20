{ pkgs }: { scheme }:
# Source: https://git.sr.ht/~misterio/shellcolord
with scheme.colors;
pkgs.writeShellScript "shell-theme-${scheme.slug}.sh" ''
  if [ "''${TERM%%[-.]*}" = "screen" ]; then
      apply_color() { echo -ne "\033P\033]$@\007\033\\"; }
  else
      apply_color() { echo -ne "\033]$@\033\\"; }
  fi

  # 16 color space
  apply_color "4;0;#${base00}" # black
  apply_color "4;1;#${base08}" # red
  apply_color "4;2;#${base0B}" # green
  apply_color "4;3;#${base0A}" # yellow
  apply_color "4;4;#${base0D}" # blue
  apply_color "4;5;#${base0E}" # magenta
  apply_color "4;6;#${base0C}" # cyan
  apply_color "4;7;#${base05}" # white
  apply_color "4;8;#${base03}" # bright black
  apply_color "4;9;#${base08}" # bright red
  apply_color "4;10;#${base0B}" # bright green
  apply_color "4;11;#${base0A}" # bright yellow
  apply_color "4;12;#${base0D}" # bright blue
  apply_color "4;13;#${base0E}" # bright magenta
  apply_color "4;14;#${base0C}" # bright cyan
  apply_color "4;15;#${base07}" # bright white
  # 256 color space
  apply_color "4;16;#${base09}" # base09
  apply_color "4;17;#${base0F}" # base0f
  apply_color "4;18;#${base01}" # base01
  apply_color "4;19;#${base02}" # base02
  apply_color "4;20;#${base04}" # base04
  apply_color "4;21;#${base06}" # base06

  # fg and bg
  apply_color "10;#${base05}" # base05
  apply_color "11;#${base00}" # base00

  # cursor
  apply_color "12;#${base05}" # base00
''
