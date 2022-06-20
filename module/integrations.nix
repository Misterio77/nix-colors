{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.colorSchemeIntegrations;

  lib-contrib = import ../lib/contrib {inherit pkgs;};

  shellTheme = lib-contrib.shellThemeFromScheme {scheme = config.colorScheme;};
in {
  options.colorSchemeIntegrations = {
    bash.enable = mkEnableOption "the shell theme for bash";
    zsh.enable = mkEnableOption "the shell theme for zsh";
    fish.enable = mkEnableOption "the shell theme for fish";
    gtk.enable = mkEnableOption "the GTK theme";
    vim.enable = mkEnableOption "the vim theme";
    gnomeNixWallpaper = {
      enable = mkEnableOption "the Gnome Nix wallpaper";
      width = mkOption {
        type = types.ints.positive;
      };
      height = mkOption {
        type = types.ints.positive;
      };
      logoScale = mkOption {
        type = types.numbers.nonnegative;
        default = 5.0;
      };
    };
  };

  config = {
    programs.bash.initExtra = mkIf cfg.bash.enable ''
      sh ${shellTheme}
    '';

    programs.zsh.initExtra = mkIf cfg.zsh.enable ''
      sh ${shellTheme}
    '';

    programs.fish.interactiveShellInit = mkIf cfg.fish.enable ''
      sh ${shellTheme}
    '';

    gtk.theme.package = mkIf cfg.gtk.enable (lib-contrib.gtkThemeFromScheme {
      scheme = config.colorScheme;
    });

    programs.vim.plugins = mkIf cfg.vim.enable [
      {
        plugin = lib-contrib.vimThemeFromScheme {scheme = config.colorScheme;};
        config = "colorscheme ${config.colorScheme.slug}";
      }
    ];

    dconf.settings."org/gnome/desktop/background" = mkIf cfg.gnomeNixWallpaper.enable {
      picture-uri = builtins.toString (lib-contrib.nixWallpaperFromScheme {
        scheme = config.colorScheme;
        inherit (cfg.gnomeNixWallpaper) width height logoScale;
      });
    };
  };
}
