let
  pkgs = import <nixpkgs> {};
  muscle = import ../muscle.nix;
in
pkgs.dockerTools.buildImage {
  name = "muscle";
  contents = [ muscle ];
}
