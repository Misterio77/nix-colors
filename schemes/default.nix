{ pkgs, lib, ... }:

# This is heavily based on rycee's work:
# https://gitlab.com/rycee/nur-expressions/

with lib;

let 
  schemeFromYaml = yaml:
  let
    json = pkgs.runCommandLocal "base16-theme.json" {
      nativeBuildInputs = [ pkgs.remarshal ];
    } ''
      remarshal --if yaml --of json \
        < ${pkgs.lib.escapeShellArg yaml} \
        > $out
    '';
    theme = builtins.fromJSON (builtins.readFile json);
  in {
    name = theme.scheme;
    author = theme.author;
    colors = pkgs.lib.filterAttrs (n: _: pkgs.lib.hasPrefix "base" n) theme;
  };
in { 
  apprentice = schemeFromYaml (import ./apprentice/apprentice.yaml);

  atelier-cave-light = schemeFromYaml (import ./atelier/atelier-cave-light.yaml);
  atelier-cave = schemeFromYaml (import ./atelier/atelier-cave.yaml);
  atelier-dune-light = schemeFromYaml (import ./atelier/atelier-dune-light.yaml);
  atelier-dune = schemeFromYaml (import ./atelier/atelier-dune.yaml);
  atelier-estuary-light = schemeFromYaml (import ./atelier/atelier-estuary-light.yaml);
  atelier-estuary = schemeFromYaml (import ./atelier/atelier-estuary.yaml);
  atelier-forest-light = schemeFromYaml (import ./atelier/atelier-forest-light.yaml);
  atelier-forest = schemeFromYaml (import ./atelier/atelier-forest.yaml);
  atelier-heath-light = schemeFromYaml (import ./atelier/atelier-heath-light.yaml);
  atelier-heath = schemeFromYaml (import ./atelier/atelier-heath.yaml);
  atelier-lakeside-light = schemeFromYaml (import ./atelier/atelier-lakeside-light.yaml);
  atelier-lakeside = schemeFromYaml (import ./atelier/atelier-lakeside.yaml);
  atelier-plateau-light = schemeFromYaml (import ./atelier/atelier-plateau-light.yaml);
  atelier-plateau = schemeFromYaml (import ./atelier/atelier-plateau.yaml);
  atelier-savanna-light = schemeFromYaml (import ./atelier/atelier-savanna-light.yaml);
  atelier-savanna = schemeFromYaml (import ./atelier/atelier-savanna.yaml);
  atelier-seaside-light = schemeFromYaml (import ./atelier/atelier-seaside-light.yaml);
  atelier-seaside = schemeFromYaml (import ./atelier/atelier-seaside.yaml);
  atelier-sulphurpool-light = schemeFromYaml (import ./atelier/atelier-sulphurpool-light.yaml);
  atelier-sulphurpool = schemeFromYaml (import ./atelier/atelier-sulphurpool.yaml);

  atlas = schemeFromYaml (import ./atlas/atlas.yaml);

  black-metal-bathory = schemeFromYaml (import ./black-metal/black-metal-bathory.yaml);
  black-metal-burzum = schemeFromYaml (import ./black-metal/black-metal-burzum.yaml);
  black-metal-dark-funeral = schemeFromYaml (import ./black-metal/black-metal-dark-funeral.yaml);
  black-metal-gorgoroth = schemeFromYaml (import ./black-metal/black-metal-gorgoroth.yaml);
  black-metal-immortal = schemeFromYaml (import ./black-metal/black-metal-immortal.yaml);
  black-metal-khold = schemeFromYaml (import ./black-metal/black-metal-khold.yaml);
  black-metal-marduk = schemeFromYaml (import ./black-metal/black-metal-marduk.yaml);
  black-metal-mayhem = schemeFromYaml (import ./black-metal/black-metal-mayhem.yaml);
  black-metal-nile = schemeFromYaml (import ./black-metal/black-metal-nile.yaml);
  black-metal-venom = schemeFromYaml (import ./black-metal/black-metal-venom.yaml);
  black-metal = schemeFromYaml (import ./black-metal/black-metal.yaml);

  blueish = schemeFromYaml (import ./blueish/blueish.yaml);

  brushtrees-dark = schemeFromYaml (import ./brushtrees/brushtrees-dark.yaml);
  brushtrees = schemeFromYaml (import ./brushtrees/brushtrees.yaml);

  circus = schemeFromYaml (import ./circus/circus.yaml);

  classic-dark = schemeFromYaml (import ./classic/classic-dark.yaml);
  classic-light = schemeFromYaml (import ./classic/classic-light.yaml);

  codeschool = schemeFromYaml (import ./codeschool/codeschool.yaml);

  colors = schemeFromYaml (import ./colors/colors.yaml);

  cupertino = schemeFromYaml (import ./cupertino/cupertino.yaml);

  da-one-black = schemeFromYaml (import ./da-one/da-one-black.yaml);
  da-one-gray = schemeFromYaml (import ./da-one/da-one-gray.yaml);
  da-one-ocean = schemeFromYaml (import ./da-one/da-one-ocean.yaml);
  da-one-paper = schemeFromYaml (import ./da-one/da-one-paper.yaml);
  da-one-white = schemeFromYaml (import ./da-one/da-one-white.yaml);

  danqing = schemeFromYaml (import ./danqing/danqing.yaml);

  darcula = schemeFromYaml (import ./darcula/darcula.yaml);

  darkmoss = schemeFromYaml (import ./darkmoss/darkmoss.yaml);

  darkviolet = schemeFromYaml (import ./darkviolet/darkviolet.yaml);

  cupcake = schemeFromYaml (import ./default/cupcake.yaml);
  default-dark = schemeFromYaml (import ./default/default-dark.yaml);
  default-light = schemeFromYaml (import ./default/default-light.yaml);
  eighties = schemeFromYaml (import ./default/eighties.yaml);
  mocha = schemeFromYaml (import ./default/mocha.yaml);
  ocean = schemeFromYaml (import ./default/ocean.yaml);

  dirtysea = schemeFromYaml (import ./dirtysea/dirtysea.yaml);

  dracula = schemeFromYaml (import ./dracula/dracula.yaml);

  equilibrium-dark = schemeFromYaml (import ./equilibrium/equilibrium-dark.yaml);
  equilibrium-gray-dark = schemeFromYaml (import ./equilibrium/equilibrium-gray-dark.yaml);
  equilibrium-gray-light = schemeFromYaml (import ./equilibrium/equilibrium-gray-light.yaml);
  equilibrium-light = schemeFromYaml (import ./equilibrium/equilibrium-light.yaml);

  decaf = schemeFromYaml (import ./espresso/decaf.yaml);

  espresso = schemeFromYaml (import ./espresso/espresso.yaml);

  eva-dim = schemeFromYaml (import ./eva/eva-dim.yaml);
  eva = schemeFromYaml (import ./eva/eva.yaml);

  framer = schemeFromYaml (import ./framer/framer.yaml);

  fruit-soda = schemeFromYaml (import ./fruit-soda/fruit-soda.yaml);

  gigavolt = schemeFromYaml (import ./gigavolt/gigavolt.yaml);

  github = schemeFromYaml (import ./github/github.yaml);

  gotham = schemeFromYaml (import ./gotham/gotham.yaml);

  gruvbox-dark-hard = schemeFromYaml (import ./gruvbox/gruvbox-dark-hard.yaml);
  gruvbox-dark-medium = schemeFromYaml (import ./gruvbox/gruvbox-dark-medium.yaml);
  gruvbox-dark-pale = schemeFromYaml (import ./gruvbox/gruvbox-dark-pale.yaml);
  gruvbox-dark-soft = schemeFromYaml (import ./gruvbox/gruvbox-dark-soft.yaml);
  gruvbox-light-hard = schemeFromYaml (import ./gruvbox/gruvbox-light-hard.yaml);
  gruvbox-light-medium = schemeFromYaml (import ./gruvbox/gruvbox-light-medium.yaml);
  gruvbox-light-soft = schemeFromYaml (import ./gruvbox/gruvbox-light-soft.yaml);

  gruvbox-material-dark-hard = schemeFromYaml (import ./gruvbox-material/gruvbox-material-dark-hard.yaml);
  gruvbox-material-dark-medium = schemeFromYaml (import ./gruvbox-material/gruvbox-material-dark-medium.yaml);
  gruvbox-material-dark-soft = schemeFromYaml (import ./gruvbox-material/gruvbox-material-dark-soft.yaml);
  gruvbox-material-light-hard = schemeFromYaml (import ./gruvbox-material/gruvbox-material-light-hard.yaml);
  gruvbox-material-light-medium = schemeFromYaml (import ./gruvbox-material/gruvbox-material-light-medium.yaml);
  gruvbox-material-light-soft = schemeFromYaml (import ./gruvbox-material/gruvbox-material-light-soft.yaml);

  hardcore = schemeFromYaml (import ./hardcore/hardcore.yaml);

  heetch-light = schemeFromYaml (import ./heetch/heetch-light.yaml);
  heetch = schemeFromYaml (import ./heetch/heetch.yaml);

  helios = schemeFromYaml (import ./helios/helios.yaml);

  horizon-dark = schemeFromYaml (import ./horizon/horizon-dark.yaml);
  horizon-light = schemeFromYaml (import ./horizon/horizon-light.yaml);
  horizon-terminal-dark = schemeFromYaml (import ./horizon/horizon-terminal-dark.yaml);
  horizon-terminal-light = schemeFromYaml (import ./horizon/horizon-terminal-light.yaml);

  humanoid-dark = schemeFromYaml (import ./humanoid/humanoid-dark.yaml);
  humanoid-light = schemeFromYaml (import ./humanoid/humanoid-light.yaml);

  ia-dark = schemeFromYaml (import ./ia/ia-dark.yaml);
  ia-light = schemeFromYaml (import ./ia/ia-light.yaml);

  icy = schemeFromYaml (import ./icy/icy.yaml);

  katy = schemeFromYaml (import ./katy/katy.yaml);

  kimber = schemeFromYaml (import ./kimber/kimber.yaml);

  emil = schemeFromYaml (import ./limelight/emil.yml);
  lime = schemeFromYaml (import ./limelight/lime.yml);

  materia = schemeFromYaml (import ./materia/materia.yaml);

  material-vivid = schemeFromYaml (import ./material-vivid/material-vivid.yaml);

  material-darker = schemeFromYaml (import ./materialtheme/material-darker.yaml);
  material-lighter = schemeFromYaml (import ./materialtheme/material-lighter.yaml);
  material-palenight = schemeFromYaml (import ./materialtheme/material-palenight.yaml);
  material = schemeFromYaml (import ./materialtheme/material.yaml);

  mellow-purple = schemeFromYaml (import ./mellow/mellow-purple.yaml);

  mexico-light = schemeFromYaml (import ./mexico-light/mexico-light.yaml);

  nebula = schemeFromYaml (import ./nebula/nebula.yaml);

  nord = schemeFromYaml (import ./nord/nord.yaml);

  nova = schemeFromYaml (import ./nova/nova.yaml);

  one-light = schemeFromYaml (import ./one-light/one-light.yaml);

  onedark = schemeFromYaml (import ./onedark/onedark.yaml);

  outrun-dark = schemeFromYaml (import ./outrun/outrun-dark.yaml);

  pandora = schemeFromYaml (import ./pandora/pandora.yaml);

  pasque = schemeFromYaml (import ./pasque/pasque.yaml);

  pinky = schemeFromYaml (import ./pinky/pinky.yaml);

  porple = schemeFromYaml (import ./porple/porple.yaml);

  primer-dark-dimmed = schemeFromYaml (import ./primer/primer-dark-dimmed.yaml);
  primer-dark = schemeFromYaml (import ./primer/primer-dark.yaml);
  primer-light = schemeFromYaml (import ./primer/primer-light.yaml);

  purpledream = schemeFromYaml (import ./purpledream/purpledream.yml);

  qualia = schemeFromYaml (import ./qualia/qualia.yaml);

  rebecca = schemeFromYaml (import ./rebecca/rebecca.yaml);

  rose-pine-dawn = schemeFromYaml (import ./rose-pine/rose-pine-dawn.yaml);
  rose-pine-moon = schemeFromYaml (import ./rose-pine/rose-pine-moon.yaml);
  rose-pine = schemeFromYaml (import ./rose-pine/rose-pine.yaml);

  sagelight = schemeFromYaml (import ./sagelight/sagelight.yaml);

  sakura = schemeFromYaml (import ./sakura/sakura.yaml);

  sandcastle = schemeFromYaml (import ./sandcastle/sandcastle.yaml);

  shadesmear-dark = schemeFromYaml (import ./shadesmear/shadesmear-dark.yaml);
  shadesmear-light = schemeFromYaml (import ./shadesmear/shadesmear-light.yaml);

  silk-dark = schemeFromYaml (import ./silk/silk-dark.yaml);
  silk-light = schemeFromYaml (import ./silk/silk-light.yaml);

  snazzy = schemeFromYaml (import ./snazzy/snazzy.yaml);

  solarflare-light = schemeFromYaml (import ./solarflare/solarflare-light.yaml);
  solarflare = schemeFromYaml (import ./solarflare/solarflare.yaml);

  solarized-dark = schemeFromYaml (import ./solarized/solarized-dark.yaml);
  solarized-light = schemeFromYaml (import ./solarized/solarized-light.yaml);

  spaceduck = schemeFromYaml (import ./spaceduck/spaceduck.yaml);

  stella = schemeFromYaml (import ./stella/stella.yaml);

  summercamp = schemeFromYaml (import ./summercamp/summercamp.yaml);
  summerfruit-dark = schemeFromYaml (import ./summerfruit/summerfruit-dark.yaml);
  summerfruit-light = schemeFromYaml (import ./summerfruit/summerfruit-light.yaml);

  synth-midnight-dark = schemeFromYaml (import ./synth-midnight/synth-midnight-dark.yaml);
  synth-midnight-light = schemeFromYaml (import ./synth-midnight/synth-midnight-light.yaml);

  tender = schemeFromYaml (import ./tender/tender.yaml);

  tokyonight = schemeFromYaml (import ./tokyonight/tokyonight.yaml);

  tomorrow-night-eighties = schemeFromYaml (import ./tomorrow/tomorrow-night-eighties.yaml);
  tomorrow-night = schemeFromYaml (import ./tomorrow/tomorrow-night.yaml);
  tomorrow = schemeFromYaml (import ./tomorrow/tomorrow.yaml);

  twilight = schemeFromYaml (import ./twilight/twilight.yaml);

  "3024" = schemeFromYaml (import ./unclaimed/3024.yaml);
  apathy = schemeFromYaml (import ./unclaimed/apathy.yaml);
  ashes = schemeFromYaml (import ./unclaimed/ashes.yaml);
  bespin = schemeFromYaml (import ./unclaimed/bespin.yaml);
  brewer = schemeFromYaml (import ./unclaimed/brewer.yaml);
  bright = schemeFromYaml (import ./unclaimed/bright.yaml);
  chalk = schemeFromYaml (import ./unclaimed/chalk.yaml);
  darktooth = schemeFromYaml (import ./unclaimed/darktooth.yaml);
  embers = schemeFromYaml (import ./unclaimed/embers.yaml);
  flat = schemeFromYaml (import ./unclaimed/flat.yaml);
  google-dark = schemeFromYaml (import ./unclaimed/google-dark.yaml);
  google-light = schemeFromYaml (import ./unclaimed/google-light.yaml);
  grayscale-dark = schemeFromYaml (import ./unclaimed/grayscale-dark.yaml);
  grayscale-light = schemeFromYaml (import ./unclaimed/grayscale-light.yaml);
  greenscreen = schemeFromYaml (import ./unclaimed/greenscreen.yaml);
  harmonic-dark = schemeFromYaml (import ./unclaimed/harmonic-dark.yaml);
  harmonic-light = schemeFromYaml (import ./unclaimed/harmonic-light.yaml);
  hopscotch = schemeFromYaml (import ./unclaimed/hopscotch.yaml);
  irblack = schemeFromYaml (import ./unclaimed/irblack.yaml);
  isotope = schemeFromYaml (import ./unclaimed/isotope.yaml);
  macintosh = schemeFromYaml (import ./unclaimed/macintosh.yaml);
  marrakesh = schemeFromYaml (import ./unclaimed/marrakesh.yaml);
  monokai = schemeFromYaml (import ./unclaimed/monokai.yaml);
  oceanicnext = schemeFromYaml (import ./unclaimed/oceanicnext.yaml);
  paraiso = schemeFromYaml (import ./unclaimed/paraiso.yaml);
  phd = schemeFromYaml (import ./unclaimed/phd.yaml);
  pico = schemeFromYaml (import ./unclaimed/pico.yaml);
  pop = schemeFromYaml (import ./unclaimed/pop.yaml);
  railscasts = schemeFromYaml (import ./unclaimed/railscasts.yaml);
  seti = schemeFromYaml (import ./unclaimed/seti.yaml);
  shapeshifter = schemeFromYaml (import ./unclaimed/shapeshifter.yaml);
  spacemacs = schemeFromYaml (import ./unclaimed/spacemacs.yaml);
  tube = schemeFromYaml (import ./unclaimed/tube.yaml);

  unikitty-dark = schemeFromYaml (import ./unikitty/unikitty-dark.yaml);
  unikitty-light = schemeFromYaml (import ./unikitty/unikitty-light.yaml);
  unikitty-reversible = schemeFromYaml (import ./unikitty/unikitty-reversible.yml);

  uwunicorn = schemeFromYaml (import ./uwunicorn/uwunicorn.yml);

  vice = schemeFromYaml (import ./vice/vice.yml);

  vulcan = schemeFromYaml (import ./vulcan/vulcan.yaml);

  windows-10-light = schemeFromYaml (import ./windows/windows-10-light.yaml);
  windows-10 = schemeFromYaml (import ./windows/windows-10.yaml);
  windows-95-light = schemeFromYaml (import ./windows/windows-95-light.yaml);
  windows-95 = schemeFromYaml (import ./windows/windows-95.yaml);
  windows-highcontrast-light = schemeFromYaml (import ./windows/windows-highcontrast-light.yaml);
  windows-highcontrast = schemeFromYaml (import ./windows/windows-highcontrast.yaml);
  windows-nt-light = schemeFromYaml (import ./windows/windows-nt-light.yaml);
  windows-nt = schemeFromYaml (import ./windows/windows-nt.yaml);

  woodland = schemeFromYaml (import ./woodland/woodland.yaml);

  xcode-dusk = schemeFromYaml (import ./xcode-dusk/xcode-dusk.yaml);

  zenburn = schemeFromYaml (import ./zenburn/zenburn.yaml);
}
