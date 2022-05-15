{ pkgs }: { scheme }:
let
  c = scheme.colors;
  slug = scheme.slug;

  red = builtins.substring 0 2;
  green = builtins.substring 2 2;
  blue = builtins.substring 4 2;
  rgb = color: "${red color}/${green color}/${blue color}";
in
pkgs.writeTextDir "conf.d/nix-base16-${slug}.fish" ''
  # based on base16-fish (https://github.com/tomyun/base16-fish)
  # based on base16-shell (https://github.com/chriskempson/base16-shell)

  if status --is-interactive
    set color00 ${rgb c.base00} # Base 00 - Black
    set color01 ${rgb c.base08} # Base 08 - Red
    set color02 ${rgb c.base0B} # Base 0B - Green
    set color03 ${rgb c.base0A} # Base 0A - Yellow
    set color04 ${rgb c.base0D} # Base 0D - Blue
    set color05 ${rgb c.base0E} # Base 0E - Magenta
    set color06 ${rgb c.base0C} # Base 0C - Cyan
    set color07 ${rgb c.base05} # Base 05 - White
    set color08 ${rgb c.base03} # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 ${rgb c.base07} # Base 07 - Bright White
    set color16 ${rgb c.base09} # Base 09
    set color17 ${rgb c.base0F} # Base 0F
    set color18 ${rgb c.base01} # Base 01
    set color19 ${rgb c.base02} # Base 02
    set color20 ${rgb c.base04} # Base 04
    set color21 ${rgb c.base06} # Base 06
    set colorfg $color07 # Base 05 - White
    set colorbg $color00 # Base 00 - Black

    if test -n "$TMUX"
      # Tell tmux to pass the escape sequences through
      # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
      function put_template; printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $argv; end;
      function put_template_var; printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $argv; end;
      function put_template_custom; printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $argv; end;
    else if string match 'screen*' $TERM
      # GNU screen (screen, screen-256color, screen-256color-bce)
      function put_template; printf '\033P\033]4;%d;rgb:%s\007\033\\' $argv; end;
      function put_template_var; printf '\033P\033]%d;rgb:%s\007\033\\' $argv; end;
      function put_template_custom; printf '\033P\033]%s%s\007\033\\' $argv; end;
    else if string match 'linux*' $TERM
      function put_template; test $argv[1] -lt 16 && printf "\e]P%x%s" $argv[1] (echo $argv[2] | sed 's/\///g'); end;
      function put_template_var; true; end;
      function put_template_custom; true; end;
    else
      function put_template; printf '\033]4;%d;rgb:%s\033\\' $argv; end;
      function put_template_var; printf '\033]%d;rgb:%s\033\\' $argv; end;
      function put_template_custom; printf '\033]%s%s\033\\' $argv; end;
    end

    # 16 color space
    put_template 0  $color00
    put_template 1  $color01
    put_template 2  $color02
    put_template 3  $color03
    put_template 4  $color04
    put_template 5  $color05
    put_template 6  $color06
    put_template 7  $color07
    put_template 8  $color08
    put_template 9  $color09
    put_template 10 $color10
    put_template 11 $color11
    put_template 12 $color12
    put_template 13 $color13
    put_template 14 $color14
    put_template 15 $color15

    # 256 color space
    put_template 16 $color16
    put_template 17 $color17
    put_template 18 $color18
    put_template 19 $color19
    put_template 20 $color20
    put_template 21 $color21

    # foreground / background / cursor color
    if test -n "$ITERM_SESSION_ID"
      # iTerm2 proprietary escape codes
      put_template_custom Pg ${c.base05} # foreground
      put_template_custom Ph ${c.base00} # background
      put_template_custom Pi ${c.base05} # bold color
      put_template_custom Pj ${c.base02} # selection color
      put_template_custom Pk ${c.base05} # selected text color
      put_template_custom Pl ${c.base05} # cursor
      put_template_custom Pm ${c.base00} # cursor text
    else
      put_template_var 10 $colorfg
      if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]
        put_template_var 11 $colorbg
        if string match 'rxvt*' $TERM # [ "''${TERM%%-*}" = "rxvt" ]
          put_template_var 708 $colorbg # internal border (rxvt)
        end
      end
      put_template_custom 12 ";7" # cursor (reverse video)
    end

    # set syntax highlighting colors
    set -U fish_color_autosuggestion ${c.base02}
    set -U fish_color_cancel -r
    set -U fish_color_command green #white
    set -U fish_color_comment ${c.base02}
    set -U fish_color_cwd green
    set -U fish_color_cwd_root red
    set -U fish_color_end brblack #blue
    set -U fish_color_error red
    set -U fish_color_escape yellow #green
    set -U fish_color_history_current --bold
    set -U fish_color_host normal
    set -U fish_color_match --background=brblue
    set -U fish_color_normal normal
    set -U fish_color_operator blue #green
    set -U fish_color_param ${c.base04}
    set -U fish_color_quote yellow #brblack
    set -U fish_color_redirection cyan
    set -U fish_color_search_match bryellow --background=${c.base02}
    set -U fish_color_selection white --bold --background=${c.base02}
    set -U fish_color_status red
    set -U fish_color_user brgreen
    set -U fish_color_valid_path --underline
    set -U fish_pager_color_completion normal
    set -U fish_pager_color_description yellow --dim
    set -U fish_pager_color_prefix white --bold #--underline
    set -U fish_pager_color_progress brwhite --background=cyan

    # clean up
    functions -e put_template put_template_var put_template_custom
  end
''
