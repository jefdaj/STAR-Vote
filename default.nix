rec {

  # to update the the sha256sum:
  # nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs-channels/archive/nixos-20.03.tar.gz
  nixpkgs = let
    inherit (import <nixpkgs> {}) stdenv fetchFromGitHub;
  in import (fetchFromGitHub {
    owner  = "nixos";
    repo   = "nixpkgs-channels";
    rev    = "nixos-20.03"; # TODO pick an actual rev
    sha256 = "13qpa916qq1kqvfj8q4zkmnfnbh2kpx0nxxg04nblai0smz97820";
  }) {};

  # to build one of these, for example star-crypto:
  # nix-build default.nix -A star-crypto
  append-only-bb  = nixpkgs.callPackage ./append-only-bb  { inherit nixpkgs; };
  star-crypto     = nixpkgs.callPackage ./star-crypto     { inherit nixpkgs; };
  # star-keygen     = nixpkgs.callPackage ./star-keygen     { inherit nixpkgs; };
  # star-terminal   = nixpkgs.callPackage ./star-terminal   { inherit nixpkgs; };
  # star-types      = nixpkgs.callPackage ./star-types      { inherit nixpkgs; };
  # star-util       = nixpkgs.callPackage ./star-util       { inherit nixpkgs; };
  # star-voter-db   = nixpkgs.callPackage ./star-voter-db   { inherit nixpkgs; };
  # star-controller = nixpkgs.callPackage ./star-controller { inherit nixpkgs; };

}
