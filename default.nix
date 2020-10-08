let

  # to update the the sha256sum:
  # nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs-channels/archive/nixos-20.03.tar.gz
  pkgs = let
    inherit (import <nixpkgs> {}) stdenv fetchFromGitHub;
  in import (fetchFromGitHub {
    owner  = "nixos";
    repo   = "nixpkgs-channels";
    rev    = "nixos-20.03";
    sha256 = "13qpa916qq1kqvfj8q4zkmnfnbh2kpx0nxxg04nblai0smz97820";
  }) {};

  # psiblast-exb = pkgs.callPackage ./psiblast-exb { };

in pkgs.hello
