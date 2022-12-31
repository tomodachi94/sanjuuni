{
  pkgs ? import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/4fe8d07066f6ea82cda2b0c9ae7aee59b2d241b3.tar.gz";
    sha256 = "sha256:06jzngg5jm1f81sc4xfskvvgjy5bblz51xpl788mnps1wrkykfhp";
  }) {}
}:

with pkgs;

let
  packages = rec {

    # The derivation for sanjuuni
    sanjuuni = stdenv.mkDerivation rec {
      pname = "sanjuuni";
      version = "0.2.0";
      src = fetchgit {
        url = "https://github.com/MCJack123/sanjuuni";
        rev = "20ebd7834010b90469e0523f01d70bff80803c02";
        sha256 = "sha256-vURQCrDGqErSv+fN5lD1qe7gWTRvlsM+gXJY6wwhJIA=";
      };

      buildInputs = [
        pkgconfig
        gcc
		ffmpeg
		poco
      ];

	installPhase = ''
  		runHook preInstall

  		install -Dm755 sanjuuni $out/bin/sanjuuni

  		runHook postInstall
		'';
    };

  };
in
  packages
