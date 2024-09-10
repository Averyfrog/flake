# gruvbox-plus.nix

{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "gruvbox-plus";
  
  src = pkgs.fetchurl {
    url = "https://github.com/SylEleuth/gruvbox-plus-icon-pack/releases/download/v5.0.1/gruvbox-plus-icon-pack-5.0.1.zip";
    sha256 = "sha256-9aMylIoMMcdny1f0qKerJibFDKgNLUgMDSg1vuKL+PE=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    ${pkgs.unzip}/bin/unzip $src -d $out/
    '';
}
