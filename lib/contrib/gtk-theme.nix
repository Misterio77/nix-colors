{ pkgs }:
{ scheme }:

let
  rendersvg = pkgs.runCommand "rendersvg" { } ''
    mkdir -p $out/bin
    ln -s ${pkgs.resvg}/bin/resvg $out/bin/rendersvg
  '';
in
pkgs.stdenv.mkDerivation rec {
  name = "generated-gtk-theme-${scheme.slug}";
  src = pkgs.fetchFromGitHub {
    owner = "nana-4";
    repo = "materia-theme";
    rev = "76cac96ca7fe45dc9e5b9822b0fbb5f4cad47984";
    sha256 = "sha256-0eCAfm/MWXv6BbCl2vbVbvgv8DiUH09TAUhoKq7Ow0k=";
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
      BTN_BG=${scheme.palette.base02}
      BTN_FG=${scheme.palette.base06}
      FG=${scheme.palette.base05}
      BG=${scheme.palette.base00}
      HDR_BTN_BG=${scheme.palette.base01}
      HDR_BTN_FG=${scheme.palette.base05}
      ACCENT_BG=${scheme.palette.base0B}
      ACCENT_FG=${scheme.palette.base00}
      HDR_FG=${scheme.palette.base05}
      HDR_BG=${scheme.palette.base02}
      MATERIA_SURFACE=${scheme.palette.base02}
      MATERIA_VIEW=${scheme.palette.base01}
      MENU_BG=${scheme.palette.base02}
      MENU_FG=${scheme.palette.base06}
      SEL_BG=${scheme.palette.base0D}
      SEL_FG=${scheme.palette.base0E}
      TXT_BG=${scheme.palette.base02}
      TXT_FG=${scheme.palette.base06}
      WM_BORDER_FOCUS=${scheme.palette.base05}
      WM_BORDER_UNFOCUS=${scheme.palette.base03}
      UNITY_DEFAULT_LAUNCHER_STYLE=False
      NAME=${scheme.slug}
      MATERIA_STYLE_COMPACT=True
    EOF

    echo "Changing colours:"
    ./change_color.sh -o ${scheme.slug} /build/gtk-colors -i False -t "$out/share/themes"
    chmod 555 -R .
  '';
}
