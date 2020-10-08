let

  # to update the the sha256sum:
  # nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs-channels/archive/nixos-20.03.tar.gz
  nixpkgs = let
    inherit (import <nixpkgs> {}) stdenv fetchFromGitHub;
  in import (fetchFromGitHub {
    owner  = "nixos";
    repo   = "nixpkgs-channels";
    rev    = "nixos-20.03";
    sha256 = "13qpa916qq1kqvfj8q4zkmnfnbh2kpx0nxxg04nblai0smz97820";
  }) {};

  append-only-bb = nixpkgs.callPackage ./append-only-bb { inherit nixpkgs; };

in append-only-bb
