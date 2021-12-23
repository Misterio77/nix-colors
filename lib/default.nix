{ pkgs }:

let
  rendersvg = pkgs.runCommandNoCC "rendersvg" { } ''
    mkdir -p $out/bin
    ln -s ${pkgs.resvg}/bin/resvg $out/bin/rendersvg
  '';
in
{
  # Takes a scheme, resulting wallpaper height and width, plus logo scale, and ouputs the generated wallpaper path
  # Example:
  # wallpaper = nixWallpaperFromScheme {
  #   scheme = config.colorscheme;
  #   width = 2560;
  #   height = 1080;
  #   logoScale = 5.0;
  # };
  nixWallpaperFromScheme = { scheme, width, height, logoScale }:
    pkgs.stdenv.mkDerivation {
      name = "generated-nix-wallpaper-${scheme.slug}.png";
      src = pkgs.writeTextFile {
        name = "template.svg";
        text = ''
          <svg width="${toString width}" height="${
            toString height
          }" version="1.1" xmlns="http://www.w3.org/2000/svg">
            <rect width="${toString width}" height="${
              toString height
            }" fill="#${scheme.colors.base01}"/>
            <svg x="${toString (width / 2 - (logoScale * 50))}" y="${
              toString (height / 2 - (logoScale * 50))
            }" version="1.1" xmlns="http://www.w3.org/2000/svg">
              <g transform="scale(${toString logoScale})">
                <g transform="matrix(.19936 0 0 .19936 80.161 27.828)">
                  <path d="m-53.275 105.84-122.2-211.68 56.157-0.5268 32.624 56.869 32.856-56.565 27.902 0.011 14.291 24.69-46.81 80.49 33.229 57.826zm-142.26 92.748 244.42 0.012-27.622 48.897-65.562-0.1813 32.559 56.737-13.961 24.158-28.528 0.031-46.301-80.784-66.693-0.1359zm-9.3752-169.2-122.22 211.67-28.535-48.37 32.938-56.688-65.415-0.1717-13.942-24.169 14.237-24.721 93.111 0.2937 33.464-57.69z" fill="#${scheme.colors.base0C}"/>
                  <path d="m-97.659 193.01 122.22-211.67 28.535 48.37-32.938 56.688 65.415 0.1716 13.941 24.169-14.237 24.721-93.111-0.2937-33.464 57.69zm-9.5985-169.65-244.42-0.012 27.622-48.897 65.562 0.1813-32.559-56.737 13.961-24.158 28.528-0.031 46.301 80.784 66.693 0.1359zm-141.76 93.224 122.2 211.68-56.157 0.5268-32.624-56.869-32.856 56.565-27.902-0.011-14.291-24.69 46.81-80.49-33.229-57.826z" fill="#${scheme.colors.base0D}" style="isolation:auto;mix-blend-mode:normal"/>
                </g>
              </g>
            </svg>
          </svg>
        '';
      };
      buildInputs = with pkgs; [ inkscape ];
      unpackPhase = "true";
      buildPhase = ''
        inkscape --export-type="png" $src -w ${toString width} -h ${
          toString height
        } -o wallpaper.png
      '';
      installPhase = "install -Dm0644 wallpaper.png $out";
    };

  # Takes a picture path and a scheme kind ("dark" or "light"), and outputs a colorscheme based on it
  # Please note the path must be accessible by your flake on pure mode
  # Example:
  # colorscheme = colorschemFromPicture {
  #   path = ./my/cool/wallpaper.png;
  #   kind = "dark";
  # };
  colorschemeFromPicture = { path, kind }:
    import (pkgs.stdenv.mkDerivation {
      name = "generated-colorscheme";
      buildInputs = with pkgs; [ flavours ];
      unpackPhase = "true";
      buildPhase = ''
        template=$(cat <<-END
        {
          slug = "$(basename ${path})-${kind}";
          name = "Generated";
          author = "nix-colors";
          colors = {
            base00 = "{{base00-hex}}";
            base01 = "{{base01-hex}}";
            base02 = "{{base02-hex}}";
            base03 = "{{base03-hex}}";
            base04 = "{{base04-hex}}";
            base05 = "{{base05-hex}}";
            base06 = "{{base06-hex}}";
            base07 = "{{base07-hex}}";
            base08 = "{{base08-hex}}";
            base09 = "{{base09-hex}}";
            base0A = "{{base0A-hex}}";
            base0B = "{{base0B-hex}}";
            base0C = "{{base0C-hex}}";
            base0D = "{{base0D-hex}}";
            base0E = "{{base0E-hex}}";
            base0F = "{{base0F-hex}}";
          };
        }
        END
        )

        flavours generate "${kind}" "${path}" --stdout | \
        flavours build <( tee ) <( echo "$template" ) > default.nix
      '';
      installPhase = "mkdir -p $out && cp default.nix $out";
    });
  # Takes a scheme, ouputs a generated materia GTK theme
  # Example:
  # theme.package = gtkThemeFromScheme {
  #   scheme = config.colorscheme;
  # };
  gtkThemeFromScheme = { scheme }:
    pkgs.stdenv.mkDerivation rec {
      name = "generated-gtk-theme-${scheme.slug}";
      src = pkgs.fetchFromGitHub {
        owner = "nana-4";
        repo = "materia-theme";
        rev = "76cac96ca7fe45dc9e5b9822b0fbb5f4cad47984";
        sha256 = "sha256-0eCAfm/MWXv6BbCl2vbVbvgv8DiUH09TAUhoKq7Ow0k=";
        fetchSubmodules = true;
      };
      buildInputs = with pkgs; [
        sassc
        bc
        which
        rendersvg
        meson
        ninja
        nodePackages.sass
        gtk4.dev
        optipng
      ];
      phases = [ "unpackPhase" "installPhase" ];
      installPhase = ''
        HOME=/build
        chmod 777 -R .
        patchShebangs .
        mkdir -p $out/share/themes
        mkdir bin
        sed -e 's/handle-horz-.*//' -e 's/handle-vert-.*//' -i ./src/gtk-2.0/assets.txt

        cat > /build/gtk-colors << EOF
          BTN_BG=${scheme.colors.base02}
          BTN_FG=${scheme.colors.base06}
          FG=${scheme.colors.base05}
          BG=${scheme.colors.base00}
          HDR_BTN_BG=${scheme.colors.base01}
          HDR_BTN_FG=${scheme.colors.base05}
          ACCENT_BG=${scheme.colors.base0B}
          ACCENT_FG=${scheme.colors.base00}
          HDR_FG=${scheme.colors.base05}
          HDR_BG=${scheme.colors.base02}
          MATERIA_SURFACE=${scheme.colors.base02}
          MATERIA_VIEW=${scheme.colors.base01}
          MENU_BG=${scheme.colors.base02}
          MENU_FG=${scheme.colors.base06}
          SEL_BG=${scheme.colors.base0D}
          SEL_FG=${scheme.colors.base0E}
          TXT_BG=${scheme.colors.base02}
          TXT_FG=${scheme.colors.base06}
          WM_BORDER_FOCUS=${scheme.colors.base05}
          WM_BORDER_UNFOCUS=${scheme.colors.base03}
          UNITY_DEFAULT_LAUNCHER_STYLE=False
          NAME=${scheme.slug}
          MATERIA_STYLE_COMPACT=True
        EOF

        echo "Changing colours:"
        ./change_color.sh -o ${scheme.slug} /build/gtk-colors -i False -t "$out/share/themes"
        chmod 555 -R .
      '';
    };
}
